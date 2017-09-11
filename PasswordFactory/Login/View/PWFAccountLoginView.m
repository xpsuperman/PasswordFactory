//
//  PWFAccountLoginView.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFAccountLoginView.h"

static CGFloat const kPWFAccountLoginViewHeight = 100.0f;

NS_ASSUME_NONNULL_BEGIN

@interface PWFAccountLoginView ()

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@end

@implementation PWFAccountLoginView

- (instancetype)initWithLoginType:(PWFLoginType)loginType
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UILabel *nameLabel = [self createLabelWithTitle:@"用户名"];
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(30);
        make.top.equalTo(self);
    }];
    
    _nameTextField = [self createTextFieldWithPlaceholder:@"请输入用户名"];
    [self addSubview:_nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right);
        make.right.equalTo(self).offset(-20);
        make.top.bottom.equalTo(nameLabel);
    }];
    
    UILabel *passwordLabel = [self createLabelWithTitle:@"密码"];
    [self addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(nameLabel);
        make.bottom.equalTo(self);
    }];
    
    _passwordTextField = [self createTextFieldWithPlaceholder:@"请输入密码"];
    [self addSubview:_passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameTextField);
        make.top.bottom.equalTo(passwordLabel);
    }];
}

- (UILabel *)createLabelWithTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    titleLabel.text = [NSString stringWithFormat:@"%@：", title];
    return titleLabel;
}

- (UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.borderStyle = UITextBorderStyleLine;
    textField.layer.borderWidth = 2.0f;
    textField.layer.borderColor = RGBCOLOR(200, 200, 200).CGColor;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:15.0f];
    textField.placeholder = placeholder;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(SCREEN_WIDTH, kPWFAccountLoginViewHeight);
}

@end

NS_ASSUME_NONNULL_END
