//
//  UITableView+QSPMVVM.h
//  ThreadingPrograming
//
//  Created by QSP on 2018/7/20.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSPTableViewVM.h"

typedef void (^QSPMVVMSetTableViewVMBlock)(QSPTableViewVM *);

@interface UITableView (QSPMVVM)

@property (strong, nonatomic, readonly) QSPTableViewVM *vm;

- (UITableView * (^)(QSPTableViewVM *))vmSet;
- (UITableView * (^)(QSPMVVMSetTableViewVMBlock))vmCreate;

@end
