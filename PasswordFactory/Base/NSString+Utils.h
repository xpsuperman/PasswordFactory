//
//  NSString+Utils.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/8.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

+ (instancetype)generateUUID;
- (NSString *)md5;
- (NSString *)urlEncode;
- (NSString *)urlDecode;

@end
