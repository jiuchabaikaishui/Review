//
//  DetailVM.m
//  Review
//
//  Created by apple on 2018/10/21.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "DetailVM.h"

@implementation DetailVM

- (RACCommand *)command {
    if (_command == nil) {
        _command = [self emptyCommand];
    }
    
    return _command;
}

+ (instancetype)detailVMWithTitle:(NSString *)title explain:(NSString *)explain andSampleClass:(NSString *)class {
    return [[self alloc] initWithTitle:title explain:explain andSampleClass:class];
}
- (instancetype)initWithTitle:(NSString *)title explain:(NSString *)explain andSampleClass:(NSString *)class {
    if (self = [super init]) {
        self.title = title;
        self.explain = explain;
        self.sampleClass = class;
    }
    
    return self;
}

@end
