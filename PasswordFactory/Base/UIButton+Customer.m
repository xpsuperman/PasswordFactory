//
//  UIButton+Customer.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/11.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "UIButton+Customer.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIButton (Customer)

+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:RGBCOLOR(4, 172, 216)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 2.0f;
    button.layer.masksToBounds = YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}


@end

NS_ASSUME_NONNULL_END
