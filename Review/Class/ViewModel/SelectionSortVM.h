//
//  SelectionSortVM.h
//  Review
//
//  Created by 綦帅鹏 on 2019/7/3.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "BaseVM.h"

@interface SelectionSortVM : BaseVM

@property (nonatomic, assign, readonly) int numberCount;
@property (nonatomic, assign, readonly) int maxNumber;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) int minPos;
@property (nonatomic, assign) BOOL animating;
@property (nonatomic, assign) BOOL animateingAll;
@property (nonatomic, strong) RACCommand *resetCommand;
@property (nonatomic, strong) RACCommand *nextCommand;
@property (nonatomic, strong) RACCommand *playCommand;

+ (instancetype)vmWithNumberCount:(int)numberCount maxNumber:(int)maxNumber;
- (instancetype)initWithNumberCount:(int)numberCount maxNumber:(int)maxNumber;

void selectionSortC(int arr[], int len);
- (void)selectionSortOC:(NSMutableArray<NSNumber *> *)array;
- (void)selectionSortSwift:(NSMutableArray<NSNumber *> *)array;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
