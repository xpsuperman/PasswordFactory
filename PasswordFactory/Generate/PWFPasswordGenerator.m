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
    NSArray *sourceArray = [self passwordSourceArray];
    //打乱数组
    NSArray *outOfOrderArray = [self makeOutOfOrderArray:sourceArray];
    //生成随机数
    NSArray *randomArray = [self generateRandom:passwordLength count:outOfOrderArray.count];
    NSMutableArray *outputArray = [[NSMutableArray alloc] init];
    for (NSNumber *number in randomArray) {
        if ([number integerValue] < outOfOrderArray.count) {
            [outputArray addObject:outOfOrderArray[[number integerValue]]];
        }
    }
    BOOL containUppercase = NO;
    for (NSString *str in [self uppercaseLetterArray]) {
        if ([outputArray containsObject:str]) {
            containUppercase = YES;
            break;
        }
    }
    
    if (!containUppercase) {
        NSArray *uppercaseArray = [self uppercaseLetterArray];
        uint32_t position = arc4random_uniform((uint32_t)outputArray.count);
        uint32_t random = arc4random_uniform((uint32_t)uppercaseArray.count);
        [outputArray replaceObjectAtIndex:position withObject:uppercaseArray[random]];
    }
    return [[outputArray copy] componentsJoinedByString:@""];
}

+ (NSArray *)passwordSourceArray
{
    static NSMutableArray *passwordArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        passwordArray = [[NSMutableArray alloc] init];
        [passwordArray addObjectsFromArray:[self lowercaseLetterArray]];
        [passwordArray addObjectsFromArray:[self uppercaseLetterArray]];
        [passwordArray addObjectsFromArray:[self numberArray]];
        [passwordArray addObjectsFromArray:[self characterArray]];
    });
    return [passwordArray copy];
}

+ (NSArray *)makeOutOfOrderArray:(NSArray *)array
{
    return [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        uint32_t i = arc4random_uniform(2);
        if (i) {
            return [obj1 compare:obj2];
        } else {
            return [obj2 compare:obj1];
        }
    }];
}

+ (NSArray *)generateRandom:(NSInteger)randomLength count:(NSInteger)count
{
    NSMutableArray *numberArray = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < count; index++) {
        [numberArray addObject:@(index)];
    }
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < randomLength; index++) {
        uint32_t randomNumber = arc4random_uniform((uint32_t)numberArray.count);
        [array addObject:numberArray[randomNumber]];
        [numberArray removeObjectAtIndex:randomNumber];
    }
    return [array copy];
}

+ (NSArray *)lowercaseLetterArray
{
    return @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z"];
}

+ (NSArray *)uppercaseLetterArray
{
    return @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
}

+ (NSArray *)numberArray
{
    return @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
}

+ (NSArray *)characterArray
{
    return @[@"{", @"}", @"[", @"]", @"(", @")"];
}

@end

NS_ASSUME_NONNULL_END
