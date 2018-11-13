//
//  NotificationViewController.m
//  Review
//
//  Created by apple on 17/5/27.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "NotificationViewController.h"
#import "Masonry.h"
#import "NotificationVM.h"

#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define Revie_Notification_Name             @"ReviewNotification"

@interface NotificationViewController ()

@property (strong, nonatomic) NotificationVM *vm;
@property (weak, nonatomic) IBOutlet UIButton *addB;
@property (weak, nonatomic) IBOutlet UIButton *postB;
@property (weak, nonatomic) IBOutlet UIButton *removeB;

@end

@implementation NotificationViewController

#pragma mark - 属性方法
- (NotificationVM *)vm {
    if (_vm == nil) {
        _vm = [[NotificationVM alloc] init];
    }
    
    return _vm;
}

#pragma mark - 控制器周期
- (void)dealloc
{
    [NotificationCenter removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUI];
    [self bindVM];
}

#pragma mark - 自定义方法
- (void)settingUI
{
}
- (void)bindVM {
    self.addB.rac_command = self.vm.addCommand;
    self.postB.rac_command = self.vm.postCommand;
    self.removeB.rac_command = self.vm.removeCommand;
    
    @weakify(self);
    [self.vm.addCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [NotificationCenter addObserver:self selector:@selector(notificationAction:) name:Revie_Notification_Name object:nil];
    }];
    [self.vm.postCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        [NotificationCenter postNotificationName:Revie_Notification_Name object:nil];
    }];
    [self.vm.removeCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [NotificationCenter removeObserver:self];
    }];
}

- (void)notificationAction:(NSNotification *)sender
{
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
}

@end
