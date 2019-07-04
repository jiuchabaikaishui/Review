//
//  SelectionSortVM.m
//  Review
//
//  Created by 綦帅鹏 on 2019/7/3.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "SelectionSortVM.h"
#import "Review-Swift.h"

@implementation SelectionSortVM

- (RACCommand *)resetCommand {
    if (_resetCommand == nil) {
        RACSignal *countS = RACObserve(self, count);
        RACSignal *indexS = RACObserve(self, index);
        RACSignal *animatingS = RACObserve(self, animating);
        RACSignal *animatingAllS = RACObserve(self, animateingAll);
        RACSignal *combineS = [RACSignal combineLatest:@[countS, indexS, animatingS, animatingAllS] reduce:^id _Nonnull(id first, id second, id third, id fourth){
            return @(([first intValue] > 0 || [second intValue] > 0) && (![third boolValue]) && (![fourth boolValue]));
        }];
        _resetCommand = [self emptyCommandWithEnabled:combineS];
    }
    
    return _resetCommand;
}
- (RACCommand *)nextCommand {
    if (_nextCommand == nil) {
        RACSignal *countS = RACObserve(self, count);
        RACSignal *animatingS = RACObserve(self, animating);
        RACSignal *animatingAllS = RACObserve(self, animateingAll);
        RACSignal *combineS = [RACSignal combineLatest:@[countS, animatingS, animatingAllS] reduce:^id _Nonnull(id first, id second, id third){
            return @([first intValue] < 8 && (![second boolValue]) && (![third boolValue]));
        }];
        _nextCommand = [self emptyCommandWithEnabled:combineS];
    }
    
    return _nextCommand;
}
- (RACCommand *)playCommand {
    RACSignal *countS = RACObserve(self, count);
    RACSignal *animatingS = RACObserve(self, animating);
    RACSignal *animatingAllS = RACObserve(self, animateingAll);
    RACSignal *combineS = [RACSignal combineLatest:@[countS, animatingS, animatingAllS] reduce:^id _Nonnull(id first, id second, id third){
        return @([first intValue] < 8 && (![second boolValue]) && (![third boolValue]));
    }];
    if (_playCommand == nil) {
        _playCommand = [self emptyCommandWithEnabled:combineS];
    }
    
    return _playCommand;
}

void selectionSortC(int array[], int len) {
    for (int i = 0; i < len - 1; i++) {
        int minPos = i;
        for (int j = i + 1; j < len; j++) {
            if (array[minPos] > array[j]) {
                minPos = j;
            }
        }
        
        if (minPos != i) {
            int temp = array[i];
            array[i] = array[minPos];
            array[minPos] = temp;
        }
    }
}

- (void)selectionSortOC:(NSMutableArray<NSNumber *> *)array {
    for (int i = 0; i < array.count - 1; i++) {
        int minPos = i;
        for (int j = i + 1; j < array.count; j++) {
            if ([array[minPos] intValue] > [array[j] intValue]) {
                minPos = j;
            }
        }
        
        if (minPos != i) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:minPos];
        }
    }
}

- (void)selectionSortSwift:(NSMutableArray<NSNumber *> *)array {
    SortModel *sort = [[SortModel alloc] init];
    [sort selectionSortWithArray:array];
}

@end
