//
//  CommonVM.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"

@interface QSPViewVM : NSObject

typedef void (^QSPSetDataMBlock)(id);

@property (strong, nonatomic, readonly) id dataM;

+ (instancetype)viewVMWithModel:(id)dataM;
- (instancetype)initWithModel:(id)dataM;

- (RACCommand *)emptyCommand;
- (RACCommand *)emptyCommandWithEnabled:(RACSignal *)enabledSignal;

- (QSPViewVM * (^)(id))dataMSet;
- (QSPViewVM * (^)(Class, QSPSetDataMBlock))dataMCreate;

@end
