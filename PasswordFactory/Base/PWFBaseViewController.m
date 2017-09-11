//
//  PWFBaseViewController.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

static NSTimeInterval const kPWFDefaultDisappearTimer = 3.0f;

@interface PWFBaseViewController ()

@end

@implementation PWFBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)showCustomerLoading:(NSString *)text
{
    [self showCustomerLoading:text afterDelay:kPWFDefaultDisappearTimer];
}

- (void)showCustomerLoading:(NSString *)text afterDelay:(NSTimeInterval)interval
{
    if (text.length) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.label.text = text;
        hud.label.textColor = [UIColor whiteColor];
        hud.margin = 10.f;
        hud.offset = CGPointMake(0, -40);
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:interval];
    }
}

@end

NS_ASSUME_NONNULL_END
