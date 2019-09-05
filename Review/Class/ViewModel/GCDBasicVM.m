//
//  GCDBasicVM.m
//  Review
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "GCDBasicVM.h"

@implementation GCDBasicVM

@synthesize buttonRCommand = _buttonRCommand;
@synthesize buttonLCommand = _buttonLCommand;
@synthesize imageURL = _imageURL;

- (RACCommand *)buttonRCommand {
    if (_buttonRCommand == nil) {
        _buttonRCommand = [[RACCommand alloc] initWithEnabled:[RACObserve(self, image) map:^id _Nullable(id  _Nullable value) {
            return value ? @(YES) : @(NO);
        }] signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal empty];
        }];
    }
    
    return _buttonRCommand;
}
- (RACCommand *)buttonLCommand {
    if (_buttonLCommand == nil) {
        _buttonLCommand = [[RACCommand alloc] initWithEnabled:[RACObserve(self, image) map:^id _Nullable(id  _Nullable value) {
            return value ? @(NO) : @(YES);
        }] signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal empty];
        }];
    }
    
    return _buttonLCommand;
}

- (NSURL *)imageURL {
    if (_imageURL == nil) {
        _imageURL = [NSURL URLWithString:@"https://img.3dmgame.com/uploads/images/news/20180903/1535945067_761578.jpg"];
    }
    
    return _imageURL;
}

- (instancetype)init {
    if (self = [super init]) {
        _title = @"异步加载图片";
    }
    
    return self;
}

@end
