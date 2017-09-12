//
//  PWFFactoryHeaderView.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/11.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFFactoryHeaderView.h"
#import "UIImage+Resize.h"

static NSInteger const kPWFPasswordMinLength = 8;
static NSInteger const kPWFPasswordDefaultLength = 26;
static NSInteger const kPWFPasswordMaxLength = 50;

NS_ASSUME_NONNULL_BEGIN

@interface PWFFactoryHeaderView ()

@property (nonatomic, strong) UITextField *passwordLengthTextField;
@property (nonatomic, assign) NSInteger currentQuantity;

@end

@implementation PWFFactoryHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:HEXCOLOR(0x333333)];
    label.text = @"密码长度";
    label.font = Font(17);
    [self addSubview:label];
    [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:(UILayoutConstraintAxisHorizontal)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.centerY.equalTo(self);
    }];
    
    UIButton *minButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [minButton setImage:[UIImage imageNamed:@"btn_minus_rest"] forState:UIControlStateNormal];
    [minButton setImage:[UIImage imageNamed:@"btn_minus_press"] forState:UIControlStateHighlighted];
    [minButton setImage:[UIImage imageNamed:@"btn_minus_disable"] forState:UIControlStateDisabled];
    [minButton addTarget:self action:@selector(didClickDecreaseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:minButton];
    [minButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(label.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(self);
    }];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleNone;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.textColor = HEXCOLOR(0x333333);
    textField.font = Font(17);
    textField.text = [NSString stringWithFormat:@"%@", @(kPWFPasswordDefaultLength)];
    self.currentQuantity = kPWFPasswordDefaultLength;
    textField.background = [UIImage imageNamed:@"text_input_bg"];
    textField.disabledBackground = [[UIImage imageNamed:@"food_input_textField_disabled"] resizableImage];
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(minButton.mas_right).offset(20);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(42);
        make.height.mas_equalTo(30);
    }];
    self.passwordLengthTextField = textField;
    @weakify(self);
    [[_passwordLengthTextField.rac_textSignal filter:^BOOL(NSString *value) {
        return [value integerValue] > 0 && [value integerValue] != self.currentQuantity;
    }] subscribeNext:^(NSString *value) {
        @strongify(self);
        NSInteger quantity = [value integerValue];
        [self handleQuantity:quantity];
    }];
    
    UIButton *increaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [increaseButton setImage:[UIImage imageNamed:@"btn_add_rest"] forState:UIControlStateNormal];
    [increaseButton setImage:[UIImage imageNamed:@"btn_add_press"] forState:UIControlStateHighlighted];
    [increaseButton setImage:[UIImage imageNamed:@"btn_add_disable"] forState:UIControlStateDisabled];
    [increaseButton addTarget:self action:@selector(didClickIncreaseButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:increaseButton];
    [increaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textField.mas_right).offset(20);
        make.right.equalTo(self).offset(-30);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(self);
    }];
    
}

- (void)didClickDecreaseButton:(id)sender
{
    NSInteger quantity = self.currentQuantity - 1;
    [self handleQuantity:quantity];
}

- (void)handleQuantity:(NSInteger)quantity
{
    if (quantity < kPWFPasswordMinLength) {
        [self showTips:[NSString stringWithFormat:@"密码长度不能小于%@", @(kPWFPasswordMinLength)]];
        self.currentQuantity = kPWFPasswordMinLength;
    } else if (quantity > kPWFPasswordMaxLength) {
        [self showTips:[NSString stringWithFormat:@"密码长度不能大于%@", @(kPWFPasswordMaxLength)]];
        self.currentQuantity = kPWFPasswordMaxLength;
    } else {
        self.currentQuantity = quantity;
    }
    self.passwordLengthTextField.text = [NSString stringWithFormat:@"%@", @(self.currentQuantity)];
}

- (void)didClickIncreaseButton:(id)sender
{
    NSInteger quantity = self.currentQuantity + 1;
    [self handleQuantity:quantity];
}

- (void)showTips:(NSString *)tips
{
    if (self.showTipsBlock) {
        self.showTipsBlock(tips);
    }
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(SCREEN_WIDTH, 50.0f);
}

@end

NS_ASSUME_NONNULL_END
