//
//  SortModel.swift
//  Review
//
//  Created by 綦帅鹏 on 2019/7/2.
//  Copyright © 2019 QSP. All rights reserved.
//

import UIKit

class SortModel: NSObject {
    func bubbleSort(array: inout Array<Int>) {
        for i in 0..<array.count - 1 {
            for j in 0..<array.count - i - 1 {
                if (array[j] > array[j + 1]) {
                    array.swapAt(j, j + 1)
                }
            }
        }
    }
    func show() {
        print("hello world!")
    }
}
