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
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(logout:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)logout:(id)sender
{
    [[PWFDataManager sharedInstance] logout];
    [PWFRouter routerWithTarget:PWFRouterLogin];
}

@end

NS_ASSUME_NONNULL_END
