//
//  JavaScriptCoreVM.m
//  Review
//
//  Created by 綦帅鹏 on 2018/11/13.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "JavaScriptCoreVM.h"

@interface JavaScriptCoreVM ()

@end

@implementation JavaScriptCoreVM

- (NSURL *)url {
    if (_url == nil) {
        _url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Review" ofType:@"html"]];
    }
    
    return _url;
}

- (RACCommand *)loadCommand {
    if (_loadCommand == nil) {
        _loadCommand = [self emptyCommand];
    }
    
    return _loadCommand;
}

- (RACCommand *)callCommand {
    if (_callCommand == nil) {
        _callCommand = [self emptyCommand];
    }
    
    return _callCommand;
}

- (RACSignal *)showSignal {
    if (_showSignal == nil) {
        _showSignal = [self rac_signalForSelector:@selector(showMessage:)];
    }
    
    return _showSignal;
}
- (RACSignal *)mixSignal {
    if (_mixSignal == nil) {
        _mixSignal = [self rac_signalForSelector:@selector(mixA:andB:)];
    }

    return _mixSignal;
}
- (RACSignal *)doSignal {
    if (_doSignal == nil) {
        _doSignal = [self rac_signalForSelector:@selector(doSomethingThenCallBack:)];
    }
    
    return _doSignal;
}

@end
