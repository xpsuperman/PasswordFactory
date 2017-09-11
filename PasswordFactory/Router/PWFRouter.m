//
//  PWFRouter.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/8.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFRouter.h"
#import "AppDelegate.h"
#import "PWFNavigationController.h"
#import "PWFLoginViewController.h"
#import "PWFFactoryViewController.h"

@implementation PWFRouter

+ (void)routerWithTarget:(PWFRouterTarget)target
{
    PWFNavigationController *navController = nil;
    if (target == PWFRouterFactory) {
        PWFFactoryViewController *factoryController = [[PWFFactoryViewController alloc] init];
        navController = [[PWFNavigationController alloc] initWithRootViewController:factoryController];
    } else if (target == PWFRouterLogin) {
        PWFLoginViewController *loginController = [[PWFLoginViewController alloc] init];
        navController = [[PWFNavigationController alloc] initWithRootViewController:loginController];
    } else {
        NSAssert(NO, @"have not this type");
    }
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *appDelegate = (AppDelegate *)application.delegate;
    appDelegate.window.rootViewController = navController;
}

@end
