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

@property (assign, nonatomic, readonly) CGFloat titleHeight;
@property (assign, nonatomic, readonly) CGFloat detailHeight;
@property (assign, nonatomic, readonly) CGFloat titleLandscapeHeight;
@property (assign, nonatomic, readonly) CGFloat detailLandscapeHeight;
@property (strong, nonatomic, readonly) id cellLandscapeHeight;

- (void)bindData;

@end
