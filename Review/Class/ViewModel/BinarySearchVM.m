//
//  BinarySearchVM.m
//  Review
//
//  Created by 綦帅鹏 on 2019/7/9.
//  Copyright © 2019 QSP. All rights reserved.
//

#import "BinarySearchVM.h"

@implementation BinarySearchVM

int binarySearchC(int array[], int lenth, int target) {
    int low = 0, high = lenth;
    while (low <= high) {
        int mid = (high + low)/2;
        if (array[mid] > target) {
            high = mid - 1;
        } else if (array[mid] < target) {
            low = mid + 1;
        } else {
            return mid;
        }
    }
    
    return -1;
}

/**
 递归方式
 */
int binarySearchCRecursion(int array[], int from, int to, int target) {
    if (from <= to) {
        int mid = (from + to)/2;
        if (array[mid] > target) {
            binarySearchCRecursion(array, from, mid - 1, target);
        } else if (array[mid] < target) {
            binarySearchCRecursion(array, mid + 1, to, target);
        } else {
            return mid;
        }
    }
    
    return -1;
}

@end
