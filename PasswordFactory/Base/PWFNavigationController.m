//
//  PWFNavigationController.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWFNavigationController ()

@end


@implementation PWFNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (![NSThread mainThread]) {
        NSLog(@"Cannot push a view controller (%@) in the background thread.", viewController);
        return;
    }
    if (self.viewControllers.count > 0 && viewController.navigationItem.leftBarButtonItem == nil) {
        [[viewController navigationItem] setLeftBarButtonItem:[viewController backBarButtonItem]];
    }
    [super pushViewController:viewController animated:animated];
}



@end

@implementation UIViewController (PWFNavigationController)

- (UIBarButtonItem *)backBarButtonItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 30, 30)];
    [button addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

NS_ASSUME_NONNULL_END
