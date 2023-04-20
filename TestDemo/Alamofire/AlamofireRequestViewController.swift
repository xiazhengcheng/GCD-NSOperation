//
//  AlamofireRequestViewController.swift
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/20.
//  Copyright © 2023 etlfab. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireRequestViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Alamofire.request("https://www.finture.id/user/api/v1/open/version-config/iOS", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            print(response)
        }
        
        NetWorkProvider.request(NetWorkApi.upGradeVersion, model: UpGradeData.self) { result in
            print(result ?? "122")
        }
    }
}
