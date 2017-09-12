//
//  PWFPasswordCell.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/12.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PWFPasswordInfo;

@interface PWFPasswordCell : UITableViewCell

@property (nonatomic, copy) void (^copyPasswordBlock)(NSString *tips);

- (void)setCellData:(PWFPasswordInfo *)passwordInfo;

@end

NS_ASSUME_NONNULL_END
