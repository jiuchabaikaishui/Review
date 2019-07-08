//
//  QuickSortVM.m
//  Review
//
//  Created by 綦帅鹏 on 2019/7/5.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "QuickSortVM.h"
#import "Review-Swift.h"

@implementation QuickSortVM

+ (instancetype)vmWithNumberCount:(int)numberCount maxNumber:(int)maxNumber {
    return [[self alloc] initWithNumberCount:numberCount maxNumber:maxNumber];
}
- (instancetype)init {
    if (self = [super init]) {
        _numberCount = 10;
        _maxNumber = 10;
        self.right = self.numberCount - 1;
        self.large = YES;
    }
    
    return self;
}
- (instancetype)initWithNumberCount:(int)numberCount maxNumber:(int)maxNumber {
    if (self = [super init]) {
        _numberCount = numberCount;
        _maxNumber = maxNumber;
        self.right = self.numberCount - 1;
    }
    
    return self;
}

- (RACCommand *)resetCommand {
    if (_resetCommand == nil) {
        RACSignal *leftS = RACObserve(self, left);
        RACSignal *rightS = RACObserve(self, right);
        RACSignal *animatingS = RACObserve(self, animating);
        RACSignal *animatingAllS = RACObserve(self, animateingAll);
        RACSignal *combineS = [RACSignal combineLatest:@[leftS, rightS, animatingS, animatingAllS] reduce:^id _Nonnull(id first, id second, id third, id fourth){
            return @(([first intValue] > 0 || [second intValue] > 0) && (![third boolValue]) && (![fourth boolValue]));
        }];
        _resetCommand = [self emptyCommandWithEnabled:combineS];
    }
    
    return _resetCommand;
}
- (RACCommand *)nextCommand {
    if (_nextCommand == nil) {
        RACSignal *leftS = RACObserve(self, left);
        RACSignal *animatingS = RACObserve(self, animating);
        RACSignal *animatingAllS = RACObserve(self, animateingAll);
        RACSignal *rightS = RACObserve(self, right);
        RACSignal *combineS = [RACSignal combineLatest:@[leftS, animatingS, animatingAllS, rightS] reduce:^id _Nonnull(id first, id second, id third, id fourth){
            return @([first intValue] < [fourth intValue] && (![second boolValue]) && (![third boolValue]));
        }];
        _nextCommand = [self emptyCommandWithEnabled:combineS];
    }
    
    return _nextCommand;
}
- (RACCommand *)playCommand {
    RACSignal *leftS = RACObserve(self, left);
    RACSignal *animatingS = RACObserve(self, animating);
    RACSignal *animatingAllS = RACObserve(self, animateingAll);
    RACSignal *rightS = RACObserve(self, right);
    RACSignal *combineS = [RACSignal combineLatest:@[leftS, animatingS, animatingAllS, rightS] reduce:^id _Nonnull(id first, id second, id third, id fourth){
        return @([first intValue] < [fourth intValue] && (![second boolValue]) && (![third boolValue]));
    }];
    if (_playCommand == nil) {
        _playCommand = [self emptyCommandWithEnabled:combineS];
    }
    
    return _playCommand;
}

void quickSortC(int array[], int left, int right) {
    if (right <= left) {
        return;
    }
    int i = left;
    int j = right;
    int k = array[left];
    while (i < j) {
        while (i < j && array[j] >= k) {
            j--;
        }
        if (i < j) {
            array[i] = array[j];
        }
        
        while (i < j && array[i] <= k) {
            i++;
        }
        if (i < j) {
            array[j] = array[i];
        }
    }
    array[i] = k;
    
    quickSortC(array, left, i - 1);
    quickSortC(array, j + 1, right);
}
- (void)quickSortOC:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right {
    if (right <= left || array.count - 1 < right - left) {
        return;
    }
    
    NSInteger i = left;
    NSInteger j = right;
    int k = [array[i] intValue];
    while (i < j) {
        while (i < j && [array[j] intValue] >= k) {
            j--;
        }
        if (i < j) {
            array[i] = array[j];
        }
        
        while (i < j && [array[i] intValue] <= k) {
            i++;
        }
        if (i < j) {
            array[j] = array[i];
        }
    }
    array[i] = @(k);
    
    [self quickSortOC:array left:left right:i - 1];
    [self quickSortOC:array left:j + 1 right:right];
}
- (void)quickSortSwift:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right {
    SortModel *sort = [[SortModel alloc] init];
    [sort quickSortWithArray:array left:left right:right];
}

@end
