//
//  QSPTableViewFooterView.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSPTableViewSectionVM.h"

@interface QSPTableViewFooterView : UITableViewHeaderFooterView

@property (strong, nonatomic, readonly) QSPTableViewSectionVM *sectionVM;

- (QSPTableViewFooterView * (^)(QSPTableViewSectionVM *))sectionVMSet;

@end
