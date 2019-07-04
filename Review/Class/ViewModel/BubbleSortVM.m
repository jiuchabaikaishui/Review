//
//  BubbleSortVM.m
//  Review
//
//  Created by 綦帅鹏 on 2019/6/28.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "BubbleSortVM.h"
#import "Review-Swift.h"

@implementation BubbleSortVM

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
            return @([first intValue] < 9 && (![second boolValue]) && (![third boolValue]));
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
        return @([first intValue] < 9 && (![second boolValue]) && (![third boolValue]));
    }];
    if (_playCommand == nil) {
        _playCommand = [self emptyCommandWithEnabled:combineS];
    }
    
    return _playCommand;
}

void bubbleSortC(int array[], int lenth) {
    for (int i = 0; i < lenth - 1; i++) {
        for (int j = 0; j < lenth - i - 1; j++) {
            if (array[j] > array[j + 1]) {
                int temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
            }
        }
    }
}
- (void)bubbleSortOC:(NSMutableArray<NSNumber *> *)array {
    for (int i = 0; i < array.count - 1; i++) {
        for (int j = 0; j < array.count - i - 1; j++) {
            if ([array[j] intValue] > [array[j + 1] intValue]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }
}
- (void)bubbleSortCSwift:(NSMutableArray<NSNumber *> *)array {
    SortModel *sort = [[SortModel alloc] init];
    [sort bubbleSortWithArray:array];
}

@end