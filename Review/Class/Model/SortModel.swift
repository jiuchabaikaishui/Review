//
//  SortModel.swift
//  Review
//
//  Created by 綦帅鹏 on 2019/7/2.
//  Copyright © 2019 QSP. All rights reserved.
//

import UIKit

@objc class SortModel: NSObject {
    @objc func bubbleSort(array: NSMutableArray) {
        for i in 0..<array.count - 1 {
            for j in 0..<array.count - i - 1 {
                if (array[j] as! Int > array[j + 1] as! Int) {
                    array.exchangeObject(at: j, withObjectAt: j + 1)
                }
            }
        }
    }
    func bubbleSort(array: inout [Int]) {
        for i in 0..<array.count - 1 {
            for j in 0..<array.count - i - 1 {
                if (array[j] > array[j + 1] ) {
                    array.swapAt(j, j + 1)
                }
            }
        }
    }
    
    @objc func selectionSort(array: NSMutableArray) {
        for i in 0..<array.count - 1 {
            var minPos = i
            for j in i + 1..<array.count {
                if (array[minPos] as! Int > array[j] as! Int) {
                    minPos = j
                }
            }
            
            if minPos != i {
                array.exchangeObject(at: i, withObjectAt: minPos)
            }
        }
    }
    func selectionSort(array: inout [Int]) {
        for i in 0..<array.count - 1 {
            var minPos = i
            for j in i + 1..<array.count {
                if (array[minPos] > array[j] ) {
                    minPos = j
                }
            }
            
            if minPos != i {
                array.swapAt(i, minPos)
            }
        }
    }
}
