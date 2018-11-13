//
//  CommonTableViewCell.h
//  ThreadManagement
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPTableViewCell.h"
#import "CommonTableViewCellVM.h"

@interface CommonTableViewCell : QSPTableViewCell

- (CommonTableViewCell *(^)(CommonTableViewCellVM *))cellVMSet;

@end
