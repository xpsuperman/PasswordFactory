//
//  PWFFactoryViewController.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFFactoryViewController.h"
#import "PWFDataManager.h"
#import "PWFRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWFFactoryViewController ()

@end

@implementation PWFFactoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"密码工厂";
    self.navigationItem.rightBarButtonItem = [self logoutBarButtonItem];
}

- (UIBarButtonItem *)logoutBarButtonItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
    [button addTarget: self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)logout:(id)sender
{
    [[PWFDataManager sharedInstance] logout];
    [PWFRouter routerWithTarget:PWFRouterLogin];
}

@end

NS_ASSUME_NONNULL_END
