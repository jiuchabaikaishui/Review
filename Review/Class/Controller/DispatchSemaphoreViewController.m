//
//  DispatchSemaphoreViewController.m
//  Review
//
//  Created by apple on 2019/8/30.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "DispatchSemaphoreViewController.h"
#import "Services.h"
#import "DispatchSemaphoreVM.h"
#import "LoadingClass.h"

@interface DispatchSemaphoreViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) DispatchSemaphoreVM *vm;

@end

@implementation DispatchSemaphoreViewController
@synthesize vm = _vm;

- (DispatchSemaphoreVM *)vm {
    if (_vm == nil) {
        _vm = [[DispatchSemaphoreVM alloc] init];
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
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
        dispatch_async(queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"----新闻接口开始调用----");
            [Services news:^(id responseObject, NSError *error) {
                NSLog(@"----新闻接口调用完成----");
                dispatch_semaphore_signal(semaphore);
            }];
        });
        dispatch_async(queue, ^{
            // dispatch_semaphore_wait会阻塞线程，因为网络回调在主线程，注意避免发生死锁
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"----天气接口开始调用----");
            [Services weatherOfCity:@"北京" completion:^(id responseObject, NSError *error) {
                NSLog(@"----天气接口调用完成----");
                dispatch_semaphore_signal(semaphore);
            }];
        });
        
        dispatch_async(queue, ^{
            // dispatch_semaphore_wait会阻塞线程，因为网络回调在主线程，注意避免发生死锁
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"----网名接口开始调用----");
            [Services namesOfPage:1 completion:^(id responseObject, NSError *error) {
                NSLog(@"----网名接口调用完成----");
                [LoadingClass showMessage:@"请看打印信息" toView:self.view];
                dispatch_semaphore_signal(semaphore);
            }];
        });
    }];
}

@end
