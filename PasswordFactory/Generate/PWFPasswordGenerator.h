//
//  PWFPasswordGenerator.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/11.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PWFPasswordGenerator : NSObject

+ (NSString *)generatePassword:(NSInteger)passwordLength;

@end

NS_ASSUME_NONNULL_END
