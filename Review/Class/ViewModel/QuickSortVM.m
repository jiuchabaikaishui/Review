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
    SwiftModel *sort = [[SwiftModel alloc] init];
    [sort quickSortWithArray:array left:left right:right];
}

@end
