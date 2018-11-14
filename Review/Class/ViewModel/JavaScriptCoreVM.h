//
//  JavaScriptCoreVM.h
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseVM.h"
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JSIneract <JSExport>

- (void)showMessage:(NSString *)message;
- (void)doSomethingThenCallBack:(NSString *)message;
- (void)mixA:(NSString *)aString andB:(NSString*)bString;

@end

@interface JavaScriptCoreVM : BaseVM <JSIneract>

@property (nonatomic, copy) NSURL *url;

@property (nonatomic, strong) RACSignal *showSignal;
@property (nonatomic, strong) RACSignal *doSignal;
@property (nonatomic, strong) RACSignal *mixSignal;

@end

NS_ASSUME_NONNULL_END
