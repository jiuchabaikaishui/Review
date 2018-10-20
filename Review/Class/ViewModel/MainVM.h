//
//  MainVM.h
//  Review
//
//  Created by apple on 2018/10/21.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "QSPViewVM.h"
#import "QSPTableViewVM.h"
#import "MainM.h"

@interface MainVM : QSPViewVM

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) QSPTableViewVM *tableViewVM;

@end
