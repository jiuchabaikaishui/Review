//
//  QSPTableViewCell.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSPTableViewCellVM.h"

@interface QSPTableViewCell : UITableViewCell

@property (strong, nonatomic, readonly) QSPTableViewCellVM *cellVM;

- (QSPTableViewCell * (^)(QSPTableViewCellVM *))cellVMSet;

@end
