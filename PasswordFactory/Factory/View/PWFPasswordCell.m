//
//  PWFPasswordCell.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/12.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFPasswordCell.h"
#import "UIButton+Customer.h"
#import "PWFPasswordInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWFPasswordCell ()

@property (nonatomic, strong) PWFPasswordInfo *passwordInfo;
@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UILabel *createDateLabel;

@end

@implementation PWFPasswordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setTextColor:HEXCOLOR(0x333333)];
    label.font = Font(15);
    [self.contentView addSubview:label];
    self.passwordLabel = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    _createDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_createDateLabel setTextColor:HEXCOLOR(0x666666)];
    _createDateLabel.font = Font(12);
    [self.contentView addSubview:_createDateLabel];
    [self.createDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(10);
        make.left.right.equalTo(label);;
        make.height.mas_equalTo(20);
    }];
    
    UIButton *button = [UIButton buttonWithTitle:@"复制" target:self selector:@selector(copyButtonClicked:)];
    button.titleLabel.font = Font(13);
    [self.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 30));
        make.left.equalTo(label.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        make.centerY.equalTo(self.contentView);
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = HEXCOLOR(0x999999);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)copyButtonClicked:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.passwordInfo.password];
    if (self.copyPasswordBlock) {
        self.copyPasswordBlock(@"内容已复制到剪切板");
    }
}

- (void)setCellData:(PWFPasswordInfo *)passwordInfo
{
    _passwordInfo = passwordInfo;
    self.passwordLabel.text = passwordInfo.password;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:passwordInfo.createDate];
    self.createDateLabel.text = [NSString stringWithFormat:@"生成时间：    %@", dateString];
}

@end

NS_ASSUME_NONNULL_END
