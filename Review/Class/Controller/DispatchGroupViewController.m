//
//  DispatchGroupViewController.m
//  Review
//
//  Created by apple on 2019/8/30.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "DispatchGroupViewController.h"
#import "Services.h"
#import "DispatchGroupVM.h"
#import "LoadingClass.h"

@interface DispatchGroupViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) DispatchGroupVM *vm;

@end

@implementation DispatchGroupViewController
@synthesize vm = _vm;

- (DispatchGroupVM *)vm {
    if (_vm == nil) {
        _vm = [[DispatchGroupVM alloc] init];
    }
    
    return _vm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindVM];
}

- (void)bindVM {
    @weakify(self);
    self.title = self.vm.title;
    self.button.rac_command = self.vm.buttonCommand;
    [self.vm.buttonCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [LoadingClass loadingToView:self.view];
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_enter(group);
        NSLog(@"----新闻接口开始调用----");
        [Services news:^(id responseObject, NSError *error) {
            NSLog(@"----新闻接口调用完成----");
            dispatch_group_leave(group);
        }];
        dispatch_group_enter(group);
        NSLog(@"----天气接口开始调用----");
        [Services weatherOfCity:@"北京" completion:^(id responseObject, NSError *error) {
            NSLog(@"----天气接口调用完成----");
            dispatch_group_leave(group);
        }];
        
        // dispatch_group_wait会阻塞线程，因为网络回调在主线程，注意避免发生死锁
//        if (dispatch_group_wait(group, DISPATCH_TIME_FOREVER) == 0) {
//            NSLog(@"----网名接口开始调用----");
//            [Services namesOfPage:1 completion:^(id responseObject, NSError *error) {
//                NSLog(@"----网名接口调用完成----");
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [LoadingClass showMessage:@"请看打印信息" toView:self.view];
//                });
//            }];
//        }
        
        dispatch_group_notify(group, queue, ^{
            NSLog(@"----网名接口开始调用----");
            [Services namesOfPage:1 completion:^(id responseObject, NSError *error) {
                NSLog(@"----网名接口调用完成----");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [LoadingClass showMessage:@"请看打印信息" toView:self.view];
                });
            }];
        });
    }];
}

@end
