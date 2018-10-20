//
//  DetailVM.h
//  Review
//
//  Created by apple on 2018/10/21.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "QSPViewVM.h"

@interface DetailVM : QSPViewVM

@property (nonatomic, copy) NSString *title;
@property (copy, nonatomic) NSString *explain;
@property (copy, nonatomic) NSString *sampleClass;
@property (nonatomic, strong) RACCommand *command;

+ (instancetype)detailVMWithTitle:(NSString *)title explain:(NSString *)explain andSampleClass:(NSString *)class;
- (instancetype)initWithTitle:(NSString *)title explain:(NSString *)explain andSampleClass:(NSString *)class;

@end
