//
//  NotificationViewController.m
//  Review
//
//  Created by apple on 17/5/27.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "NotificationViewController.h"
#import "Masonry.h"

#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define Revie_Notification_Name             @"ReviewNotification"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

#pragma mark - 控制器周期
- (void)dealloc
{
    [NotificationCenter removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUi];
}

- (void)settingUi
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"发送通知" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@50);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
    [NotificationCenter addObserver:self selector:@selector(notificationAction:) name:Revie_Notification_Name object:nil];
}

- (void)buttonAction:(UIButton *)sender
{
    [NotificationCenter postNotificationName:Revie_Notification_Name object:nil];
}
- (void)notificationAction:(NSNotification *)sender
{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
}

@end
