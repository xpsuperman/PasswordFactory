//
//  PWFFactoryHeaderView.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/11.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PWFFactoryHeaderView : UIView

@property (nonatomic, readonly) NSInteger currentQuantity;
@property (nonatomic, copy, nullable) void (^showTipsBlock)(NSString *tips);

@end

NS_ASSUME_NONNULL_END
