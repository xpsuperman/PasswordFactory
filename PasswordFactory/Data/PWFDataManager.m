//
//  PWFDataManager.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFDataManager.h"
#import "PWFAccountInfo.h"
#import "YapDatabase.h"
#import "PWFError.h"
#import "NSString+Utils.h"
#import "PWFPasswordInfo.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const kPWFSqliteName = @"PWFDataManager.sqlite";
static NSString * const kPWFAccountCollection = @"PWFAccountCollection";
static NSString * const kPWFPasswordCollection = @"PWFPasswordCollection";
static NSString * const kPWFLoginNameKey = @"PWFLoginName";
static NSString * const kPWFLoginTimeKey = @"PWFLoginTime";

static double const kPWFLoginTimeInterval = 2.0 * 60 * 60;//登录时间为两个小时

@interface PWFDataManager ()

@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) PWFAccountInfo *loginAccount;
@property (nonatomic, strong) YapDatabase *database;
@property (nonatomic, strong) YapDatabaseConnection *databaseReadConnection;
@property (nonatomic, strong) YapDatabaseConnection *databaseWriteConnection;

@end

@implementation PWFDataManager

+ (PWFDataManager *)sharedInstance
{
    static PWFDataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *databasePath = [self databasePath];
        _database = [[YapDatabase alloc] initWithPath:databasePath];
        _databaseReadConnection = [_database newConnection];
        _databaseWriteConnection = [_database newConnection];
        [self readDefaultLogin];
    }
    return self;
}


- (void)readDefaultLogin
{
    @weakify(self);
    [self.databaseReadConnection readWithBlock:^(YapDatabaseReadTransaction * _Nonnull transaction) {
        @strongify(self);
        NSString *loginName = [transaction objectForKey:kPWFLoginNameKey inCollection:kPWFAccountCollection];
        if (loginName.length) {
            self.loginAccount = [[PWFAccountInfo alloc] initWithName:loginName];
        }
        NSDate *loginTime = [transaction objectForKey:kPWFLoginTimeKey inCollection:kPWFAccountCollection];
        if (loginName.length && loginTime) {
            NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:loginTime];
            if (interval < kPWFLoginTimeInterval) {
                self.isLogin = YES;
            }
        }
    }];
}
/**
 Login Info
 **/
- (void)registerWithName:(NSString *)name password:(NSString *)password completion:(nullable PWFDataCompletionBlock)completion
{
    if (!name.length || !password.length) {
        PWFError *error = [PWFError errorWithDomain:@"用户名或密码不存在" code:PWFErrorCodeNormal];
        if (completion) {
            completion(NO, error);
        }
        return;
    }
    __block BOOL registerSuccess = NO;
    [_databaseReadConnection readWithBlock:^(YapDatabaseReadTransaction * _Nonnull transaction) {
        NSString *tempPassword = [transaction objectForKey:name inCollection:kPWFAccountCollection];
        if (!tempPassword.length) {
            registerSuccess = YES;
        }
    }];
    PWFError *error = nil;
    if (!registerSuccess) {
        error = [PWFError errorWithDomain:@"该用户已注册" code:PWFErrorCodeNormal];
    } else {
        //写入注册信息
        [self writeLoginName:name password:password];
    }
    if (completion) {
        completion(registerSuccess, error);
    }

}

- (void)loginWithName:(NSString *)name password:(NSString *)password completion:(nullable PWFDataCompletionBlock)completion
{
    if (!name.length || !password.length) {
        PWFError *error = [PWFError errorWithDomain:@"用户名或密码不存在" code:PWFErrorCodeNormal];
        if (completion) {
            completion(NO, error);
        }
        return;
    }
    __block BOOL loginSuccess = NO;
    __block PWFError *error = nil;
    @weakify(self);
    [self.databaseReadConnection readWithBlock:^(YapDatabaseReadTransaction * _Nonnull transaction) {
        @strongify(self);
        NSString *tempPassword = [transaction objectForKey:name inCollection:kPWFAccountCollection];
        if (tempPassword.length) {
            loginSuccess = [[password md5] isEqualToString:tempPassword];
            if (!loginSuccess) {
                error = [PWFError errorWithDomain:@"密码错误" code:PWFErrorCodeNormal];
            } else {
                [self writeLoginName:name];
            }
        } else {
            error = [PWFError errorWithDomain:@"该用户没有注册" code:PWFErrorCodeNormal];
        }
    }];

    if (completion) {
        completion(loginSuccess, error);
    }
}

- (void)logout
{
    @weakify(self);
    [_databaseWriteConnection asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction * _Nonnull transaction) {
        [transaction removeObjectForKey:kPWFLoginTimeKey inCollection:kPWFAccountCollection];
    } completionBlock:^{
        @strongify(self);
        self.isLogin = NO;
    }];
}

#pragma mark -
#pragma mark Private Methods
- (NSString *)databasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *baseDir = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [baseDir stringByAppendingPathComponent:kPWFSqliteName];
}

- (void)writeLoginName:(NSString *)name
{
    [self writeLoginName:name password:nil];
}

- (void)writeLoginName:(NSString *)name password:(NSString * _Nullable )password
{
    @weakify(self);
    [_databaseWriteConnection asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction * _Nonnull transaction) {
        [transaction setObject:name forKey:kPWFLoginNameKey inCollection:kPWFAccountCollection];
        [transaction setObject:[NSDate date] forKey:kPWFLoginTimeKey inCollection:kPWFAccountCollection];
        if (password.length) {
            [transaction setObject:[password md5] forKey:name inCollection:kPWFAccountCollection];
        }
    } completionBlock:^{
        @strongify(self);
        self.isLogin = YES;
        self.loginAccount = [[PWFAccountInfo alloc] initWithName:name];
    }];
}

#pragma mark -
#pragma mark Password Service
- (void)savePassword:(NSString *)password completion:(nullable PWFDataCompletionBlock)completion
{
    if (!self.loginAccount.name.length) {
        if (completion) {
            PWFError *error = [PWFError errorWithDomain:@"用户未登录" code:PWFErrorCodeNormal];
            completion(NO, error);
        }
        return;
    }
    __block NSMutableArray *passwordArray = nil;
    NSString *key = [NSString stringWithFormat:@"password_%@", self.loginAccount.name];
    [_databaseReadConnection readWithBlock:^(YapDatabaseReadTransaction * _Nonnull transaction) {
        NSArray *array = [transaction objectForKey:key inCollection:kPWFPasswordCollection];
        passwordArray = [NSMutableArray arrayWithArray:array];
    }];

    PWFPasswordInfo *passwordInfo = [[PWFPasswordInfo alloc] initWithPassword:password createDate:[NSDate date]];
    [passwordArray addObject:passwordInfo];
    [_databaseWriteConnection asyncReadWriteWithBlock:^(YapDatabaseReadWriteTransaction * _Nonnull transaction) {
        [transaction setObject:passwordArray forKey:key inCollection:kPWFPasswordCollection];
    } completionBlock:^{
        if (completion) {
            completion(YES, nil);
        }
    }];
}

- (void)queryPassword:(void (^)(NSArray * _Nullable passwordArray,  PWFError * _Nullable error))completion
{
    if (!self.loginAccount.name.length) {
        if (completion) {
            PWFError *error = [PWFError errorWithDomain:@"用户未登录" code:PWFErrorCodeNormal];
            completion(nil, error);
        }
        return;
    }
    [_databaseReadConnection readWithBlock:^(YapDatabaseReadTransaction * _Nonnull transaction) {
        NSString *key = [NSString stringWithFormat:@"password_%@", self.loginAccount.name];
        NSArray *array = [transaction objectForKey:key inCollection:kPWFPasswordCollection];
        if (completion) {
            completion(array, nil);
        }
    }];

}

- (void)deletePassword:(NSString *)passwordID completion:(nullable PWFDataCompletionBlock)completion
{
    
}

@end

NS_ASSUME_NONNULL_END
