//
//  PWFRouter.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/8.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PWFRouterTarget)
{
    PWFRouterLogin,
    PWFRouterFactory
};

@interface PWFRouter : NSObject

+ (void)routerWithTarget:(PWFRouterTarget)target;

@end
