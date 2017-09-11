//
//  PWFAccountLoginView.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PWFLoginType){
    PWFLoginType_Register = 0,
    PWFLoginType_Login
};

@interface PWFAccountLoginView : UIView

@property (nonatomic, readonly) UITextField *nameTextField;
@property (nonatomic, readonly) UITextField *passwordTextField;

- (instancetype)initWithLoginType:(PWFLoginType)loginType;

@end

NS_ASSUME_NONNULL_END
