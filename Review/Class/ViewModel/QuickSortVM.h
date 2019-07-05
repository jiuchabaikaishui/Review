//
//  QuickSortVM.h
//  Review
//
//  Created by 綦帅鹏 on 2019/7/5.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "BaseVM.h"

@interface QuickSortVM : BaseVM

@property (nonatomic, assign) int count;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) BOOL animating;
@property (nonatomic, assign) BOOL animateingAll;
@property (nonatomic, strong) RACCommand *resetCommand;
@property (nonatomic, strong) RACCommand *nextCommand;
@property (nonatomic, strong) RACCommand *playCommand;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
