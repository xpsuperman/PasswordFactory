//
//  UIButton+Customer.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/11.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Customer)

+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
