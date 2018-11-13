//
//  MainVM.h
//  Review
//
//  Created by apple on 2018/10/21.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "BaseVM.h"
#import "QSPTableViewVM.h"
#import "MainCellM.h"

@interface MainVM : BaseVM

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) QSPTableViewVM *tableViewVM;

@end
