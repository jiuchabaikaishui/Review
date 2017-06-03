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

#define Row_Count               2
#define Screen_Width            [UIScreen mainScreen].bounds.size.width
#define Screen_Height           [UIScreen mainScreen].bounds.size.height
#define Button_Height           50

@interface JavaScriptCoreViewController ()<UIWebViewDelegate, JSIneract>

@property (weak,nonatomic) UIWebView *webView;
@property (strong,nonatomic) JSContext *context;

@end

@implementation JavaScriptCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUi];
}

#pragma mark - 自定义方法
- (void)settingUi
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSArray *arr = @[@{@"title": @"OC加载JS", @"selectorName": @"loadJSCode:"},
                     @{@"title": @"OC调用JS方法", @"selectorName": @"jsFunction:"}
                     ];
    
    int rowNum = arr.count > 0 ? (int)(arr.count - 1)/Row_Count + 1 : 0;
    CGFloat spacing = 8.0;
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(Button_Height + spacing)*rowNum - spacing);
    }];
    
    CGFloat W = (Screen_Width - spacing*(Row_Count + 1))/Row_Count;
    for (int index = 0; index < arr.count; index++) {
        int row = index/Row_Count;
        int column = index%Row_Count;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor = [UIColor whiteColor];
        NSDictionary *dic = arr[0];
        [button setTitle:dic[@"title"] forState:UIControlStateNormal];
        [button addTarget:self action:NSSelectorFromString(dic[@"selectorName"]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(spacing + column*(W + spacing));
            make.top.equalTo(webView.mas_bottom).offset(spacing + row*(Button_Height + spacing));
            make.width.equalTo(@(W));
            make.height.equalTo(@(Button_Height));
        }];
    }
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Review" ofType:@"html"]]]];
}

#pragma mark - 触摸点击方法
- (void)loadJSCode:(UIButton *)sender
{
    [self.context evaluateScript:@"alert('你好！');"];
}
- (void)jsFunction:(UIButton *)sender
{
//    JSContext *context = [[JSContext alloc] init];
//    [self.context evaluateScript:@"callback('你好!');"];
//    [self.context evaluateScript:@"alertCallback('你好啊，','小丽！')"];
    
    JSValue *callBack = self.context[@"callback"];
    [callBack callWithArguments:@[@"大家好！"]];
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
    self.context[@"OC"] = self;
    __weak typeof(self) weakSealf = self;
    self.context[@"showMessage"] = ^(NSString *message){
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertCtr addAction:cancel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSealf presentViewController:alertCtr animated:YES completion:nil];
        });
    };
    self.context[@"showTitleAndMessage"] = ^(NSString *title, NSString *message){
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertCtr addAction:cancel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSealf presentViewController:alertCtr animated:YES completion:nil];
        });
    };
    self.context[@"doSomethingThenCallBack"] = ^{
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertCtr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入传入的数据!";
            [textField addTarget:weakSealf action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertCtr addAction:cancel];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *textField = [alertCtr.textFields firstObject];
            JSValue *callback = weakSealf.context[@"callback"];
            [callback callWithArguments:@[textField.text]];
        }];
        [alertCtr addAction:ok];
        ok.enabled = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSealf presentViewController:alertCtr animated:YES completion:nil];
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
