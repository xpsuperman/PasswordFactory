//
//  PWFError.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/8.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, PWFErrorCode)
{
    PWFErrorCodeNormal =    (1 << 0)
};

@interface PWFError : NSError

+ (PWFError *)errorWithDomain:(NSString *)domain code:(PWFErrorCode)code;

@end
