//
//  QSPTableViewHeaderFooterView.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/19.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSPTableViewSectionVM.h"

@interface QSPTableViewHeaderView : UITableViewHeaderFooterView

@property (strong, nonatomic, readonly) QSPTableViewSectionVM *sectionVM;

- (QSPTableViewHeaderView * (^)(QSPTableViewSectionVM *))sectionVMSet;

@end
