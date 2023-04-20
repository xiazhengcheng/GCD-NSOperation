//
//  CommonModel.swift
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/20.
//  Copyright © 2023 etlfab. All rights reserved.
//

import UIKit
import HandyJSON

struct UpGradeData: HandyJSON {
    
    var description: String?
    var id: Int?
    var max_version: Int?
    var min_version: Int?
    var type: Int?
    var url: String?
}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var returnData: ReturnData<T>?
    
}
struct ReturnData<T: HandyJSON>: HandyJSON {
    var message:String?
    var returnData: T?
    var stateCode: Int = 0
}
