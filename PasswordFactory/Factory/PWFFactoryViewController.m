//
//  PWFFactoryViewController.m
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#import "PWFFactoryViewController.h"
#import "PWFDataManager.h"
#import "PWFRouter.h"
#import "PWFFactoryHeaderView.h"
#import "UIButton+Customer.h"
#import "PWFPasswordHistoryViewController.h"
#import "PWFPasswordGenerator.h"
#import "PWFDataManager.h"
#import "PWFError.h"

NS_ASSUME_NONNULL_BEGIN

@interface PWFFactoryViewController ()

@property (nonatomic, strong) PWFFactoryHeaderView *headerView;
@property (nonatomic, strong) UILabel *generatePasswordLabel;
@property (nonatomic, strong) UIButton *copyedButton;

@end

@implementation PWFFactoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"密码工厂";
    self.navigationItem.rightBarButtonItem = [self logoutBarButtonItem];
    [self setupUI];
}

- (void)loadView
{
    UIControl *control = [[UIControl alloc] init];
    [control addTarget:self action:@selector(controlClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.view = control;
}

- (UIBarButtonItem *)logoutBarButtonItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
    [button addTarget: self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)logout:(id)sender
{
    [[PWFDataManager sharedInstance] logout];
    [PWFRouter routerWithTarget:PWFRouterLogin];
}

- (void)controlClicked:(id)sender
{
    [self.view endEditing:YES];
}

- (void)setupUI
{
    PWFFactoryHeaderView *headerView = [[PWFFactoryHeaderView alloc] init];
    @weakify(self);
    headerView.showTipsBlock = ^(NSString *tips) {
        @strongify(self);
        [self showCustomerLoading:tips];
    };
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(150);
        make.left.right.equalTo(self.view);
    }];
    self.headerView = headerView;
    
    UIButton *generateButton = [UIButton buttonWithTitle:@"生成密码" target:self selector:@selector(generatePassword:)];
    [self.view addSubview:generateButton];
    [generateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.centerX.equalTo(self.view);
        make.top.equalTo(headerView.mas_bottom).offset(50);
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor blackColor]];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = Font(17);
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(generateButton.mas_bottom).offset(30);
        make.height.mas_equalTo(20);
    }];
    self.generatePasswordLabel = label;
    
    _copyedButton = [UIButton buttonWithTitle:@"复制" target:self selector:@selector(copyButtonClick:)];
    _copyedButton.titleLabel.font = Font(13);
    [self.view addSubview:_copyedButton];
    _copyedButton.hidden = YES;
    [self.copyedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(10);
        make.centerY.equalTo(label);
        make.size.mas_equalTo(CGSizeMake(40, 30));
        make.right.equalTo(self.view).offset(-10);
    }];
    
    UIButton *passwordHistoryButton = [UIButton buttonWithTitle:@"查看历史" target:self selector:@selector(checkHistoryPassword:)];
    [self.view addSubview:passwordHistoryButton];
    [passwordHistoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.centerX.equalTo(self.view);
        make.top.equalTo(label.mas_bottom).offset(150);
    }];
}

#pragma mark -
#pragma mark Selector Methods
- (void)generatePassword:(id)sender
{
    NSString *password = [PWFPasswordGenerator generatePassword:self.headerView.currentQuantity];
    self.generatePasswordLabel.text = password;
    self.copyedButton.hidden = NO;
    //把生成的密码存入到数据库
    [[PWFDataManager sharedInstance] savePassword:password completion:^(BOOL success, PWFError * _Nullable error) {
        if (success) {
            NSLog(@"生成密码成功");
        } else if (error) {
            [self showCustomerLoading:error.domain];
        } else {
            NSLog(@"未知错误");
        }
    }];
}

- (void)copyButtonClick:(id)sender
{
    //把文本拷贝到剪切板
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.generatePasswordLabel.text];
    [self showCustomerLoading:@"内容已复制到剪切板"];
}

- (void)checkHistoryPassword:(id)sender
{
    PWFPasswordHistoryViewController *historyController = [[PWFPasswordHistoryViewController alloc] init];
    [self.navigationController pushViewController:historyController animated:YES];
}

@end

NS_ASSUME_NONNULL_END
