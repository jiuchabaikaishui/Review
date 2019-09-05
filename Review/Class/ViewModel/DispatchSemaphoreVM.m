//
//  DispatchSemaphoreVM.m
//  Review
//
//  Created by apple on 2019/8/30.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "DispatchSemaphoreVM.h"

@implementation DispatchSemaphoreVM
@synthesize buttonCommand = _buttonCommand;

- (RACCommand *)buttonCommand {
    if (_buttonCommand == nil) {
        _buttonCommand = [self emptyCommand];
    }
    
    return _buttonCommand;
}

- (instancetype)init {
    if (self = [super init]) {
        _title = @"网络请求依次执行";
    }
    
    return self;
}

@end
