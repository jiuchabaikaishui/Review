//
//  CommonVM.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPViewVM.h"

@implementation QSPViewVM
@synthesize dataM = _dataM;

+ (instancetype)viewVMWithModel:(id)dataM {
    return [[self alloc] initWithModel:dataM];
}
- (instancetype)initWithModel:(id)dataM {
    if (self = [super init]) {
        self.dataMSet(dataM);
    }
    
    return self;
}

- (RACCommand *)emptyCommand {
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
}
- (RACCommand *)emptyCommandWithEnabled:(RACSignal *)enabledSignal {
    return [[RACCommand alloc] initWithEnabled:enabledSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal empty];
    }];
}

- (void)setDataMSet:(id)dataM {
    _dataM = dataM;
}
- (QSPViewVM * (^)(id))dataMSet {
    return ^(id dataM){
        self.dataMSet = dataM;
        
        return self;
    };
}
- (QSPViewVM * (^)(Class, QSPSetDataMBlock))dataMCreate {
    return ^(Class class, QSPSetDataMBlock block){
        id obj = [[class alloc] init];
        if (block) {
            block(obj);
        }
        self.dataMSet(obj);
        
        return self;
    };
}

@end
