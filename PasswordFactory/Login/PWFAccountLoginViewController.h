//
//  PWFAccountLoginViewController.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/8.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class PWFAccountLoginView;

@interface PWFAccountLoginViewController : PWFBaseViewController

@property (nonatomic, assign) BOOL hasAccount;
@property (nonatomic, readonly) PWFAccountLoginView *loginView;
@property (nonatomic, readonly) UIButton *loginButton;

- (void)setupAccountUI;
- (BOOL)accountAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
