//
//  PWFPasswordInfo.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/12.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PWFPasswordInfo : NSObject <NSCoding>

@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) NSDate *createDate;

- (instancetype)initWithPassword:(NSString *)password createDate:(NSDate *)createDate;

@end

NS_ASSUME_NONNULL_END
