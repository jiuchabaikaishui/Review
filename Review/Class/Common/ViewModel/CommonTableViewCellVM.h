//
//  CommonTableViewCellVM.h
//  ThreadManagement
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPTableViewCellVM.h"
#import "CommonM.h"

@interface CommonTableViewCellVM : QSPTableViewCellVM

@property (assign, nonatomic, readonly) CGRect titleRect;
@property (assign, nonatomic, readonly) CGRect detailRect;

@end
