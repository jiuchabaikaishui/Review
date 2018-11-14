//
//  JavaScriptCoreVM.m
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "JavaScriptCoreVM.h"

@interface JavaScriptCoreVM ()

@property (weak, nonatomic) id<RACSubscriber> showSubscriber;
@property (weak, nonatomic) id<RACSubscriber> doSubscriber;
@property (weak, nonatomic) id<RACSubscriber> mixSubscriber;

@end

@implementation JavaScriptCoreVM

- (NSURL *)url {
    if (_url == nil) {
        _url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Review" ofType:@"html"]];
    }
    
    return _url;
}

- (RACSignal *)showSignal {
    if (_showSignal == nil) {
        @weakify(self);
        _showSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            self.showSubscriber = subscriber;
            return [RACDisposable disposableWithBlock:^{
                [subscriber sendCompleted];
            }];
        }];
    }
    
    return _showSignal;
}
- (RACSignal *)doSignal {
    if (_doSignal == nil) {
        @weakify(self);
        _doSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            self.doSubscriber = subscriber;
            return [RACDisposable disposableWithBlock:^{
                [subscriber sendCompleted];
            }];
        }];
    }
    
    return _doSignal;
}
- (RACSignal *)mixSignal {
    if (_mixSignal == nil) {
        @weakify(self);
        _mixSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            self.mixSubscriber = subscriber;
            return [RACDisposable disposableWithBlock:^{
                [subscriber sendCompleted];
            }];
        }];
    }
    
    return _mixSignal;
}

#pragma mark - <JSIneract>代理方法
- (void)showMessage:(NSString *)message
{
    [self.showSubscriber sendNext:message];
}
- (void)doSomethingThenCallBack:(NSString *)message
{
    [self.doSubscriber sendNext:message];
}
- (void)mixA:(NSString *)aString andB:(NSString *)bString
{
    [self.mixSubscriber sendNext:@[aString, bString]];
}

@end
