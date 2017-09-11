//
//  PWFError.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/8.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFError.h"

@implementation PWFError

+ (PWFError *)errorWithDomain:(NSString *)domain code:(PWFErrorCode)code
{
    return [self errorWithDomain:domain code:code userInfo:nil];
}

@end
