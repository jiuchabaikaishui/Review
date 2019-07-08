//
//  QuickSortVM.h
//  Review
//
//  Created by 綦帅鹏 on 2019/7/5.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "BaseVM.h"

@interface QuickSortVM : BaseVM

@property (nonatomic, assign) BOOL large;
@property (nonatomic, assign, readonly) int numberCount;
@property (nonatomic, assign, readonly) int maxNumber;
@property (nonatomic, assign) int left;
@property (nonatomic, assign) int right;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) BOOL animating;
@property (nonatomic, assign) BOOL animateingAll;
@property (nonatomic, strong) RACCommand *resetCommand;
@property (nonatomic, strong) RACCommand *nextCommand;
@property (nonatomic, strong) RACCommand *playCommand;

+ (instancetype)vmWithNumberCount:(int)numberCount maxNumber:(int)maxNumber;
- (instancetype)initWithNumberCount:(int)numberCount maxNumber:(int)maxNumber;

void quickSortC(int array[], int left, int right);
- (void)quickSortOC:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right;
- (void)quickSortSwift:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
