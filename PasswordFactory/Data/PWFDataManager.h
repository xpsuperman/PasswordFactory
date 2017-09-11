//
//  PWFDataManager.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PWFAccountInfo;
@class PWFError;

NS_ASSUME_NONNULL_BEGIN

typedef void(^PWFLoginCompletionBlock)(BOOL success,  PWFError * _Nullable error);

@interface PWFDataManager : NSObject

@property (nonatomic, readonly) BOOL isLogin;
@property (nonatomic, readonly) PWFAccountInfo *loginAccount;

+ (PWFDataManager *)sharedInstance;

/**
    Login Info
 **/
- (void)registerWithName:(NSString *)name password:(NSString *)password completion:(nullable PWFLoginCompletionBlock)completion;
- (void)loginWithName:(NSString *)name password:(NSString *)password completion:(nullable PWFLoginCompletionBlock)completion;
- (void)logout;

@end

NS_ASSUME_NONNULL_END
