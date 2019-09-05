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
#import <WebKit/WebKit.h>

@interface DetailViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (weak, nonatomic) UIButton *button;
@property (weak, nonatomic) UIProgressView *progressView;
@property (weak, nonatomic) WKWebView *webView;

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
- (UIProgressView *)progressView {
    if (_progressView == nil) {
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.progress = 0.0f;
        [self.view addSubview:progressView];
        _progressView = progressView;
    }
    
    return _progressView;
}
- (WKWebView *)webView {
    if (_webView == nil) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKPreferences *preferences = [[WKPreferences alloc] init];
        config.preferences = preferences;
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        //用于进行JavaScript注入
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:wkUScript];
        
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        webView.allowsBackForwardNavigationGestures = YES;
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        [self.view addSubview:webView];
        _webView = webView;
        
        if (self.vm.isNet) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.vm.explain]]];
        } else {
            NSURL *url = [[NSBundle mainBundle] URLForResource:self.vm.explain withExtension:nil];
            if (url) {
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [webView loadRequest:request];
            } else {
                [webView loadData:[self.vm.explain dataUsingEncoding:NSUTF8StringEncoding] MIMEType:@"text/plain" characterEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
            }
        }
    }
    
    return _webView;
}


#pragma mark - 控制器周期
- (void)dealloc {
    [self.webView.configuration.userContentController removeAllUserScripts];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.height.equalTo(@(2.0f));
    }];
}
- (void)bindVM {
    self.title = self.vm.title;
    
    @weakify(self);
    if (self.vm.sampleClass && (![self.vm.sampleClass isEqualToString:@""])) {
        [self.button setTitle:self.vm.buttonTitle forState:UIControlStateNormal];
        self.button.rac_command = self.vm.command;
        [self.vm.command.executionSignals subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            UIViewController *nextCtr = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:self.vm.sampleClass];
            [self.navigationController pushViewController:nextCtr animated:YES];
        }];
    }
    
    RACSignal *progressSignal = RACObserve(self.webView, estimatedProgress);
    RAC(self.progressView, progress) = progressSignal;
    RAC(self.progressView, hidden) = [progressSignal map:^id _Nullable(id  _Nullable value) {
        return @([value floatValue] == 1);
    }];
}

#pragma <WKUIDelegate>代理方法
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    
    return nil;
}

@end
