//
//  PWFPasswordHistoryViewController.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/11.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFPasswordHistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWFPasswordHistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *passwordArrays;

@end

@implementation PWFPasswordHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"密码列表";
    [self queryPasswordList];
}

- (void)queryPasswordList
{
    
}

#pragma mark -
#pragma mark UITableViewDatasource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.passwordArrays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    NSString *password = self.passwordArrays[indexPath.row];
    cell.textLabel.text = password;
    return cell;
}

@end

NS_ASSUME_NONNULL_END
