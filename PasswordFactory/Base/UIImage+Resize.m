//
//  UIImage+Resize.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/11.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "UIImage+Resize.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIImage (Resize)

- (UIImage *)resizableImage
{
    CGFloat top = floor(self.size.height / 2);
    CGFloat bottom = self.size.height - top - 1;
    CGFloat left = floor(self.size.width / 2);
    CGFloat right = self.size.width - left - 1;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
}

@end

NS_ASSUME_NONNULL_END
