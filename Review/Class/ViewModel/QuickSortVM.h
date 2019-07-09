//
//  QuickSortVM.h
//  Review
//
//  Created by 綦帅鹏 on 2019/7/5.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "BaseVM.h"

@interface QuickSortVM : BaseVM

void quickSortC(int array[], int left, int right);
- (void)quickSortOC:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right;
- (void)quickSortSwift:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
