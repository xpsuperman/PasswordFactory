//
//  PWFRegisterViewController.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFRegisterViewController.h"
#import "PWFDataManager.h"
#import "PWFAccountLoginView.h"
#import "PWFRouter.h"
#import "PWFError.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWFRegisterViewController ()

@end

@implementation PWFRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupAccountUI];
}

- (void)setupAccountUI
{
    [super setupAccountUI];
}

#pragma mark -
#pragma mark Selector Methods
- (BOOL)accountAction:(id)sender
{
    if ([super accountAction:sender]) {
        [[PWFDataManager sharedInstance] registerWithName:self.loginView.nameTextField.text password:self.loginView.passwordTextField.text completion:^(BOOL success, PWFError * _Nullable error) {
            if (success) {
                [PWFRouter routerWithTarget:PWFRouterFactory];
            } else if (error) {
                [self showCustomerLoading:error.domain];
            } else {
                [self showCustomerLoading:@"注册失败"];
            }
        }];
        return YES;
    }
    return NO;
}



@end

NS_ASSUME_NONNULL_END
