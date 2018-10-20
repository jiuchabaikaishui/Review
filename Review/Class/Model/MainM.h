//
//  MainM.h
//  Review
//
//  Created by apple on 2018/10/21.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "CommonM.h"

@interface MainM : CommonM

@property (copy, nonatomic) NSString *explain;
@property (copy, nonatomic) NSString *sampleClass;

+ (instancetype)mainMWithDic:(NSDictionary *)dic;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
