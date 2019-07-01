//
//  CommonTableViewSectionVM.h
//  ThreadManagement
//
//  Created by QSP on 2018/7/23.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "QSPTableViewSectionVM.h"
#import "CommonM.h"

@interface CommonTableViewSectionVM : QSPTableViewSectionVM

@property (assign, nonatomic, readonly) CGFloat headerTitleHeight;
@property (assign, nonatomic, readonly) CGFloat headerDetailHeight;
@property (assign, nonatomic, readonly) CGFloat headerTitleLandscapeHeight;
@property (assign, nonatomic, readonly) CGFloat headerDetailLandscapeHeight;
@property (strong, nonatomic, readonly) id headerLandscapeHeight;

@end
