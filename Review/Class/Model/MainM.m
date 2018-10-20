//
//  MainM.m
//  Review
//
//  Created by apple on 2018/10/21.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "MainM.h"

@implementation MainM

+ (instancetype)mainMWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        if (dic) {
            self.titleSet(dic[@"title"]);
            self.detailSet(dic[@"describe"]);
            self.explain = dic[@"explain"];
            self.sampleClass = dic[@"sampleClass"];
        }
    }
    
    return self;
}

@end
