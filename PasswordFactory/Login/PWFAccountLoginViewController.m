//
//  PWFAccountLoginViewController.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/8.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFAccountLoginViewController.h"
#import "PWFAccountLoginView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWFAccountLoginViewController ()

@property (nonatomic, strong) PWFAccountLoginView *loginView;

@end

@implementation PWFAccountLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)loadView
{
    UIControl *control = [[UIControl alloc] init];
    [control addTarget:self action:@selector(controlClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.view = control;
}

- (void)setupAccountUI
{
    NSString *functionTitle = self.hasAccount ? @"登录" : @"注册";
    self.navigationItem.title = functionTitle;

    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(160, 160));
        make.top.equalTo(self.view).offset(60);
    }];
    
    _loginView = [[PWFAccountLoginView alloc] initWithLoginType:PWFLoginType_Login];
    [self.view addSubview:_loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(iconImageView.mas_bottom).offset(20);
    }];
    
    _loginButton = [self createButtonWithTitle:functionTitle selector:@selector(accountAction:)];
    [self.view addSubview:_loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.loginView.mas_bottom).offset(30);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(30);
    }];
}

- (UIButton *)createButtonWithTitle:(NSString *)title selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:RGBCOLOR(4, 172, 216)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 2.0f;
    button.layer.masksToBounds = YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}


#pragma mark -
#pragma mark Selector Methods
- (void)controlClicked:(id)sender
{
    [self.view endEditing:YES];
}

- (BOOL)accountAction:(id)sender
{
    if (!self.loginView.nameTextField.text.length) {
        [self showCustomerLoading:@"用户名不能为空"];
        return NO;
    }
    if (!self.loginView.passwordTextField.text.length) {
        [self showCustomerLoading:@"密码不能为空"];
        return NO;
    }
    return YES;
}

@end

NS_ASSUME_NONNULL_END
