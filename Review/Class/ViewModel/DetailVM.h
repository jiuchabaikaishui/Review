//
//  DetailVM.h
//  Review
//
//  Created by apple on 2018/10/21.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseVM.h"

@interface DetailVM : BaseVM

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *buttonTitle;
@property (assign, nonatomic, getter=isNet) BOOL net;
@property (copy, nonatomic) NSString *explain;
@property (copy, nonatomic) NSString *sampleClass;
@property (nonatomic, strong) RACCommand *command;

+ (instancetype)detailVMWithTitle:(NSString *)title net:(BOOL)net explain:(NSString *)explain andSampleClass:(NSString *)class;
- (instancetype)initWithTitle:(NSString *)title net:(BOOL)net explain:(NSString *)explain andSampleClass:(NSString *)class;

@end
