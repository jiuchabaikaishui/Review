//
//  CommonModel.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "BaseM.h"

@interface CommonM : BaseM

@property (copy, nonatomic, readonly) NSString *title;
@property (copy, nonatomic, readonly) NSString *detail;

- (CommonM * (^)(NSString *))titleSet;
- (CommonM * (^)(NSString *))detailSet;

@end
