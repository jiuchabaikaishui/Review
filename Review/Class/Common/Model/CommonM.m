//
//  CommonModel.m
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "CommonM.h"

@implementation CommonM

- (void)setTitleSet:(NSString *)title {
    _title = title;
}
- (void)setDetailSet:(NSString *)detail {
    _detail = detail;
}
- (CommonM * (^)(NSString *))titleSet {
    return ^(NSString *value){
        self.titleSet = value;
        
        return self;
    };
}
- (CommonM * (^)(NSString *))detailSet {
    return ^(NSString *value){
        self.detailSet = value;
        
        return self;
    };
}

@end
