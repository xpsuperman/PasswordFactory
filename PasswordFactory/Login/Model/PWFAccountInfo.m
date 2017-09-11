//
//  PWFAccountInfo.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFAccountInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWFAccountInfo ()

@property (nonatomic, copy) NSString *name;

@end

@implementation PWFAccountInfo

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
