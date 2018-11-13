//
//  JavaScriptCoreViewController.m
//  Review
//
//  Created by apple on 17/5/31.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "JavaScriptCoreViewController.h"
#import "Masonry.h"
#import <objc/runtime.h>
#import "JavaScriptCoreVM.h"

#define Row_Count               2
#define Screen_Width            [UIScreen mainScreen].bounds.size.width
#define Screen_Height           [UIScreen mainScreen].bounds.size.height
#define Button_Height           50

@interface JavaScriptCoreViewController () <UIWebViewDelegate>

@property (strong, nonatomic) JavaScriptCoreVM *vm;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *loadB;
@property (weak, nonatomic) IBOutlet UIButton *callB;
@property (strong,nonatomic) JSContext *context;

@end

@implementation JavaScriptCoreViewController

#pragma mark - 属性方法
- (JavaScriptCoreVM *)vm {
    if (_vm == nil) {
        _vm = [[JavaScriptCoreVM alloc] init];
    }
    
    return _vm;
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
- (void)loadBAction:(UIButton *)sender {
    [self.context evaluateScript:@"alert('你好！');"];
}
- (void)bindVM {
    self.loadB.rac_command = self.vm.loadCommand;
    self.callB.rac_command = self.vm.callCommand;
    
    @weakify(self);
    [self.vm.loadCommand.executionSignals subscribeNext:^(RACSignal *x) {
        @strongify(self);
        [self.context evaluateScript:@"alert('你好！');"];
    }];
    [self.vm.callCommand.executionSignals subscribeNext:^(RACSignal *x) {
        @strongify(self);
        JSValue *callBack = self.context[@"callback"];
        [callBack callWithArguments:@[@"大家好！"]];
        [x subscribeNext:^(id  _Nullable x) {
            DebugLog(@"---------%@", x);
        }];
    }];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.vm.url]];
    
    [self.vm.showSignal subscribeNext:^(NSString *x) {
        @strongify(self);
        [self showMessage:x];
    }];
    [self.vm.doSignal subscribeNext:^(NSString *x) {
        @strongify(self);
        [self doSomethingThenCallBack:x];
    }];
    [self.vm.mixSignal subscribeNext:^(NSArray *x) {
        @strongify(self);
        [self mixA:[x firstObject] andB:[x lastObject]];
    }];
}

#pragma mark - <UIWebViewDelegate>代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //从webview上获取相应的JSContext。
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //设置异常处理
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        [JSContext currentContext].exception = exception;
        NSLog(@"exception:%@",exception);
    };
    //注入JS需要的“OC”对象
    K_WeakSelf
    self.context[@"OC"] = self.vm;
    self.context[@"showMessage"] = ^(NSString *message){
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertCtr addAction:cancel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf presentViewController:alertCtr animated:YES completion:nil];
        });
    };
    self.context[@"showTitleAndMessage"] = ^(NSString *title, NSString *message){
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertCtr addAction:cancel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf presentViewController:alertCtr animated:YES completion:nil];
        });
    };
    self.context[@"doSomethingThenCallBack"] = ^{
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertCtr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入传入的数据!";
            [textField addTarget:weakSelf action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertCtr addAction:cancel];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *textField = [alertCtr.textFields firstObject];
            JSValue *callback = weakSelf.context[@"callback"];
            [callback callWithArguments:@[textField.text]];
        }];
        [alertCtr addAction:ok];
        ok.enabled = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf presentViewController:alertCtr animated:YES completion:nil];
        });
    };
}
- (void)textFieldChange:(UITextField *)sender
{
    UIAlertController *alertCtr = (UIAlertController *)self.presentedViewController;
    UIAlertAction *okAction = [alertCtr.actions lastObject];
    if (sender.text.length > 0) {
        okAction.enabled = YES;
    }
    else
    {
        okAction.enabled = NO;
    }
}

#pragma mark - <JSIneract>代理方法
- (void)showMessage:(NSString *)message
{
    NSLog(@"current:%@",[NSThread currentThread]);// 子线程
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"JS 调用了 OC" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    });
}
- (void)mixA:(NSString *)aString andB:(NSString *)bString
{
    NSLog(@"A:%@ and B:%@",aString,bString);
    JSValue *alertCallback = self.context[@"alertCallback"];
    [alertCallback callWithArguments:@[aString,bString]];
}
- (void)doSomethingThenCallBack:(NSString *)message
{
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertCtr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入传入的数据!";
        [textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertCtr addAction:cancel];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = [alertCtr.textFields firstObject];
        JSValue *callback = self.context[@"callback"];
        [callback callWithArguments:@[textField.text]];
    }];
    [alertCtr addAction:ok];
    ok.enabled = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertCtr animated:YES completion:nil];
    });
}

@end
