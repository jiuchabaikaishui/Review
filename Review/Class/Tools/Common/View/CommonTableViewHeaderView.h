//
//  CommonTableVieweHeaderView.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/18.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPTableViewHeaderView.h"
#import "CommonTableViewSectionVM.h"

@interface CommonTableViewHeaderView : QSPTableViewHeaderView

- (QSPTableViewHeaderView * (^)(CommonTableViewSectionVM *))sectionVMSet;

@end
