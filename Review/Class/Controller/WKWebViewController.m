//
//  WKWebViewController.m
//  Review
//
//  Created by apple on 2019/9/1.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"


@interface WKWebViewController () <WKUIDelegate, WKScriptMessageHandler>
@property (weak, nonatomic) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *loadButton;

@end

@implementation WKWebViewController

- (void)dealloc {
    [self.webView.configuration.userContentController removeAllUserScripts];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"与JS交互";
    
    // 1. 配置首选项
    WKPreferences *preferences = [[WKPreferences alloc] init];
    // 最小字体大小
    preferences.minimumFontSize = 12;
    // 设置是否支持javaScript 默认是支持的
    preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    // 2. 这个类主要用来做native与JavaScript的交互管理
    WKUserContentController *contentCtr = [[WKUserContentController alloc] init];
    WKUserScript *script = [[WKUserScript alloc] initWithSource:@"function alertCallback(aString,bString){ alert(aString+bString); }" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [contentCtr addUserScript:script];
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    [contentCtr addUserScript:[[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES]];
    __weak typeof(self) weakSelf = self;
    [contentCtr addScriptMessageHandler:weakSelf name:@"showMessage"];
    [contentCtr addScriptMessageHandler:weakSelf name:@"showTitleAndMessage"];
    [contentCtr addScriptMessageHandler:weakSelf name:@"doSomethingThenCallBack"];
    
    // 3. 配置对象
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
    configuration.allowsInlineMediaPlayback = YES;
    // 设置视频是否需要用户手动播放  设置为NO则会允许自动播放
    configuration.requiresUserActionForMediaPlayback = YES;
    // 设置是否允许画中画技术 在特定设备上有效
    configuration.allowsPictureInPictureMediaPlayback = YES;
    configuration.userContentController = contentCtr;
    
    // 4. 创建webView
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    webView.allowsBackForwardNavigationGestures = YES;
    [self.view insertSubview:webView atIndex:0];
    self.webView = webView;
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.loadButton.mas_top);
    }];
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"webView.html" withExtension:nil];
    [webView loadRequest:[NSURLRequest requestWithURL:path]];
    
    webView.UIDelegate = self;
    
    // 5. 监听加载进度
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.progress = 0.0f;
    [self.view addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.height.equalTo(@(1.0f));
    }];
    
    RACSignal *progressSignal = RACObserve(self.webView, estimatedProgress);
    RAC(progressView, progress) = progressSignal;
    RAC(progressView, hidden) = [progressSignal map:^id _Nullable(id  _Nullable value) {
        return @([value floatValue] == 1);
    }];
}

- (IBAction)loadJS:(UIButton *)sender {
    [self.webView evaluateJavaScript:@"callback('A');" completionHandler:nil];
}
- (IBAction)exitJS:(id)sender {
    [self.webView evaluateJavaScript:@"alertCallback('A', 'B');" completionHandler:nil];
}

#pragma mark - <WKScriptMessageHandler>代理方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
//    NSLog(@"---------begin\nname: %@\nbody: %@\nframeInfo: %@\n---------end",message.name,message.body,message.frameInfo);
    
    if ([message.name isEqual:@"showMessage"]) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:message.name message:message.body[@"message"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    } else if ([message.name isEqualToString:@"showTitleAndMessage"]) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:message.body[@"tittle"] message:message.body[@"message"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    } else if ([message.name isEqualToString:@"doSomethingThenCallBack"]) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"回调" message:@"请输入信息：" preferredStyle:UIAlertControllerStyleAlert];
        [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"回调参数";
        }];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            UITextField *textField = controller.textFields.firstObject;
            [self.webView evaluateJavaScript:[NSString stringWithFormat:@"callback('%@')", textField.text] completionHandler:nil];
        }];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    }
}


#pragma mark - <WKUIDelegate>代理方法
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:webView.title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alter addAction:action];
    [self presentViewController:alter animated:YES completion:nil];
}

@end
