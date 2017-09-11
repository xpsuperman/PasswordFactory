//
//  PWFNavigationController.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PWFNavigationController : UINavigationController

@end


@interface UIViewController (PWFNavigationController)

- (UIBarButtonItem *)backBarButtonItem;

@end

NS_ASSUME_NONNULL_END
