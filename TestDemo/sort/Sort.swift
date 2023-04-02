//
//  Sort.swift
//  TestDemo
//
//  Created by xiazhengcheng on 2023/3/31.
//  Copyright © 2023 etlfab. All rights reserved.
//

import UIKit

class Sort: NSObject {
    
    override init() {
        var array = [3,2,6,20,4,8]
//                array.bubbleSort()
//                array.fastSort(left: 0, right: array.count - 1)
        array.insertSort()
        print(array)
    }
    
}

extension Array where Element: Comparable {
    //冒泡排序
    public mutating func bubbleSort() {
        let count = self.count
        for i in 0..<count {
            for j in 0..<(count - 1 - i) {
                print(1)
                if self[j] > self[j + 1] {
                    let temp = self[j+1]
                    self[j+1] = self[j]
                    self[j] = temp
                }
            }
        }
    }
    
    //快速排序
    public mutating func fastSort(left: Int, right: Int) {
        if right - left <= 0 { return }
        var flagIndex = left
        let flagValue = self[left]
        
        
        for index in left..<right + 1 {
            print(1)
            let value = self[index]
            if(value < flagValue) {
                self[flagIndex] = value
                flagIndex += 1
                self[index] = self[flagIndex]
                self[flagIndex] = flagValue
            }
        }
        
        //        for index in stride(from: left + 1, to: right + 1, by: 1) {
        //            let value = self[index]
        //            if(value < flagValue) {
        //                self[flagIndex] = value
        //                flagIndex += 1
        //                self[index] = self[flagIndex]
        //                self[flagIndex] = flagValue
        //            }
        //        }
        fastSort(left: left, right: flagIndex - 1)
        fastSort(left: flagIndex + 1, right: right)
    }
    
    //插入排序
    public mutating func insertSort() {
        let count  = self.count
        guard count > 1 else { return }
        for i in 1..<count {
            let temp = self[i]
            for j in (0..<i).reversed() {
                print(1)
                if(self[j] > temp) {
                    self.swapAt(j, j+1)
                } else {
                    break
                }
            }
        }
    }
    
    //双路快排
    

}





