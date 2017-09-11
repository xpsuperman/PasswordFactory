//
//  PWFPasswordGenerator.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/11.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFPasswordGenerator.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PWFPasswordGenerator

+ (NSString *)generatePassword:(NSInteger)passwordLength
{
    return
}

+ (NSArray *)passwordSourceArray
{
    __block NSMutableArray *paswordArray = [[NSMutableArray alloc] init];
    return @[];
}

+ (NSArray *)lowercaseLetterArray
{
    return @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z"];
}

+ (NSArray *)upper

@end

NS_ASSUME_NONNULL_END
