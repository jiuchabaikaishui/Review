//
//  SwiftModel.swift
//  Review
//
//  Created by 綦帅鹏 on 2019/7/9.
//  Copyright © 2019 QSP. All rights reserved.
//

import UIKit

@objc class SwiftModel: NSObject {
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
    
    @objc func quickSort(array: NSMutableArray, left: Int, right: Int) {
        if (left >= right || array.count - 1 < right - left) {
            return
        }
        
        var i = left
        var j = right
        let k = array.object(at: i) as! Int
        while i < j {
            while i < j && (array[j] as! Int) >= k {
                j -= 1
            }
            if i < j {
                array[i] = array[j]
            }
            
            while i < j && (array[i] as! Int) <= k {
                i += 1
            }
            if i < j {
                array[j] = array[i]
            }
        }
        array[i] = k
        
        quickSort(array: array, left: left, right: i - 1)
        quickSort(array: array, left: j + 1, right: right)
    }
    func quickSort(array: inout [Int], left: Int, right: Int) {
        if left <= right || array.count - 1 < right - left {
            return
        }
        
        var i = left
        var j = right
        let k = array[i]
        while i < j {
            while i < j && array[j] >= k {
                j -= 1
            }
            if i < j {
                array[i] = array[j]
            }
            
            while i < j && array[i] <= k {
                i += 1
            }
            if i < j {
                array[j] = array[i]
            }
        }
        array[i] = k
        
        quickSort(array: &array, left: left, right: i - 1)
        quickSort(array: &array, left: j + 1, right: right)
    }
}
