//
//  PWFPasswordHistoryViewController.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/11.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFPasswordHistoryViewController.h"
#import "PWFDataManager.h"
#import "PWFError.h"
#import "PWFPasswordCell.h"
#import "PWFPasswordInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWFPasswordHistoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTabelView;
@property (nonatomic, copy) NSArray *passwordArrays;

@end

@implementation PWFPasswordHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"密码列表";
    [self setupUI];
    [self queryPasswordList];
}

- (void)setupUI
{
    _contentTabelView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _contentTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTabelView.dataSource = self;
    _contentTabelView.delegate = self;
    [self.view addSubview:_contentTabelView];
    [self.contentTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)queryPasswordList
{
    [[PWFDataManager sharedInstance] queryPassword:^(NSArray * _Nonnull passwordArray, PWFError * _Nonnull error) {
        if (error) {
            [self showCustomerLoading:error.domain];
        } else {
            [self handleData:passwordArray];
        }
    }];
}

- (void)handleData:(NSArray *)passwordArray
{
    self.passwordArrays = [passwordArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDate *date1 = [(PWFPasswordInfo *)obj1 createDate];
        NSDate *date2 = [(PWFPasswordInfo *)obj2 createDate];
        return [date2 compare:date1];
    }];
}

#pragma mark -
#pragma mark UITableViewDatasource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.passwordArrays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PWFPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[PWFPasswordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self);
        cell.copyPasswordBlock = ^(NSString *tips) {
            @strongify(self);
            [self showCustomerLoading:tips];
        };
    }
    PWFPasswordInfo *password = self.passwordArrays[indexPath.row];
    [cell setCellData:password];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end

NS_ASSUME_NONNULL_END
