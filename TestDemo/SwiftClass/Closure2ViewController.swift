//
//  ClosureViewController.swift
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/15.
//  Copyright © 2023 etlfab. All rights reserved.
//

import UIKit

class Closure2ViewController: BaseViewController {

    lazy var closure: (()->()) = {() in
        self.run()
    }
    
    func run() {
        print("run")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    deinit {
        print("dealloc")
    }
}
