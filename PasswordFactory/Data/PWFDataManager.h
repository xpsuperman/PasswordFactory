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

typedef void(^PWFDataCompletionBlock)(BOOL success, PWFError * _Nullable error);

@interface PWFDataManager : NSObject

@property (nonatomic, readonly) BOOL isLogin;
@property (nonatomic, readonly) PWFAccountInfo *loginAccount;

+ (PWFDataManager *)sharedInstance;

/**
    Login Info
 **/
- (void)registerWithName:(NSString *)name password:(NSString *)password completion:(nullable PWFDataCompletionBlock)completion;
- (void)loginWithName:(NSString *)name password:(NSString *)password completion:(nullable PWFDataCompletionBlock)completion;
- (void)logout;

/**
    password service
 **/

- (void)savePassword:(NSString *)password completion:(nullable PWFDataCompletionBlock)completion;
- (void)queryPassword:(void (^)(NSArray * _Nullable passwordArray,  PWFError * _Nullable error))completion;
- (void)deletePassword:(NSString *)passwordID completion:(nullable PWFDataCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
