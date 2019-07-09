//
//  DetailViewController.m
//  Review
//
//  Created by apple on 17/5/26.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "DetailViewController.h"
#import <objc/runtime.h>
#import "SampleBaseViewController.h"
#import "Masonry.h"

@interface DetailViewController ()

@property (weak, nonatomic) UIButton *button;
@property (weak, nonatomic) UIWebView *webView;

@end

@implementation DetailViewController


#pragma mark - 属性方法
- (UIButton *)button {
    if (_button == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:button];
        _button = button;
    }
    
    return _button;
}
- (UIWebView *)webView {
    if (_webView == nil) {
        UIWebView *webView = [[UIWebView alloc] init];
        [self.view addSubview:webView];
        _webView = webView;
    }
    
    return _webView;
}


#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     //队列
     //全局队列
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
     
     //主队列
     queue = dispatch_get_main_queue();
     
     //串行队列
     queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
     
     //并行队列
     queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
     
     dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
     NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
     for (NSInteger index = 0; index < 10000; index++) {
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
     [mArr addObject:[NSNumber numberWithInteger:index]];
     dispatch_semaphore_signal(semaphore);
     });
     }
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     });
     dispatch_group_t group = dispatch_group_create();
     dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     
     });
     */
    
    [self settingUI];
    [self bindVM];
}


#pragma mark - 自定义方法
- (void)settingUI
{
    if (self.vm.sampleClass && (![self.vm.sampleClass isEqualToString:@""])) {
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
            if (@available(iOS 11.0, *)) {
                make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
                make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            } else {
                make.left.right.equalTo(self.view);
            }
        }];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.equalTo(self.button.mas_top).offset(-8.0);
            if (@available(iOS 11.0, *)) {
                make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
                make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            } else {
                make.left.right.equalTo(self.view);
            }
        }];
    } else {
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
            if (@available(iOS 11.0, *)) {
                make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
                make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            } else {
                make.left.right.equalTo(self.view);
            }
        }];
    }
}
- (void)bindVM {
    self.title = self.vm.title;
    NSString *path = [[NSBundle mainBundle] pathForResource:self.vm.explain ofType:nil];
    if (path) {
        NSURL *url = [NSURL URLWithString:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    } else {
        [self.webView loadData:[self.vm.explain dataUsingEncoding:NSUTF8StringEncoding] MIMEType:@"text/plain" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
    }
    if (self.vm.sampleClass && (![self.vm.sampleClass isEqualToString:@""])) {
        [self.button setTitle:self.vm.buttonTitle forState:UIControlStateNormal];
        self.button.rac_command = self.vm.command;
        @weakify(self);
        [self.vm.command.executionSignals subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            UIViewController *nextCtr = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:self.vm.sampleClass];
            [self.navigationController pushViewController:nextCtr animated:YES];
        }];
    }
}

//- (BOOL)class:(Class)class haveTheProperty:(NSString *)propertyName
//{
//    unsigned int count = 0;
//    objc_property_t *propertys = class_copyPropertyList(class, &count);
//    for (int index = 0; index < count; index++) {
//        NSString *name = [NSString stringWithUTF8String:property_getName(propertys[index])];
//        if ([name isEqualToString:propertyName]) {
//            return YES;
//        }
//    }
//    
//    return NO;
//}

@end
