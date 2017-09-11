//
//  ViewController.m
//  PasswordFactory
//
//  Created by Xu Peng on 2017/8/3.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "ViewController.h"
#import "PWFRouter.h"
#import "PWFDataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    [self checkAccountInfo];
}

- (void)setupUI
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(320, 320));
    }];
}

- (void)checkAccountInfo //用户冷启动之后两个小时之内算登录成功
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL isLogin = [[PWFDataManager sharedInstance] isLogin];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [PWFRouter routerWithTarget:isLogin ? PWFRouterFactory : PWFRouterLogin];
        });
    });
}

@end

NS_ASSUME_NONNULL_END
