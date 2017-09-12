//
//  PWFPasswordInfo.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/12.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFPasswordInfo.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PWFPasswordInfo

- (instancetype)initWithPassword:(NSString *)password createDate:(NSDate *)createDate
{
    self = [super init];
    if (self) {
        _password = password;
        _createDate = createDate;
    }
    return self;
}


- (nullable instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.password = [decoder decodeObjectForKey:@"password"];
        self.createDate = [decoder decodeObjectForKey:@"createDate"];
    }    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.password forKey:@"password"];
    [encoder encodeObject:self.createDate forKey:@"createDate"];
}

@end

NS_ASSUME_NONNULL_END
