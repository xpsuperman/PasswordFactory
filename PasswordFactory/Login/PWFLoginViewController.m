//
//  PWFLoginViewController.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFLoginViewController.h"
#import "PWFAccountLoginView.h"
#import "PWFRegisterViewController.h"
#import "PWFDataManager.h"
#import "PWFError.h"
#import "PWFRouter.h"
#import "PWFAccountInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWFLoginViewController ()

@end

@implementation PWFLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hasAccount = YES;
    [self setupAccountUI];
    if ([PWFDataManager sharedInstance].loginAccount) {
        self.loginView.nameTextField.text = [PWFDataManager sharedInstance].loginAccount.name;
    }
}

- (void)setupAccountUI
{
    [super setupAccountUI];
    
    UILabel *registerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [registerLabel setTextColor:RGBCOLOR(3, 78, 162)];
    [registerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [registerLabel setText:@"没有账号?"];
    registerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:registerLabel];
    [registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.loginButton.mas_bottom).offset(60);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *registerButton = [self createButtonWithTitle:@"注册" selector:@selector(toRegister:)];
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.centerX.equalTo(self.loginButton);
        make.top.equalTo(registerLabel.mas_bottom).offset(10);
    }];
}

#pragma mark -
#pragma mark Selector Methods
- (BOOL)accountAction:(id)sender
{
    if ([super accountAction:sender]) {
        [[PWFDataManager sharedInstance] loginWithName:self.loginView.nameTextField.text password:self.loginView.passwordTextField.text completion:^(BOOL success, PWFError * _Nullable error) {
            if (success) {
                [PWFRouter routerWithTarget:PWFRouterFactory];
            } else if (error) {
                [self showCustomerLoading:error.domain];
            } else {
                [self showCustomerLoading:@"登录信息有误"];
            }
        }];
        return YES;
    }
    return NO;
}

- (void)toRegister:(id)sender
{
    PWFRegisterViewController *registerController = [[PWFRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerController animated:YES];
}

@end

NS_ASSUME_NONNULL_END
