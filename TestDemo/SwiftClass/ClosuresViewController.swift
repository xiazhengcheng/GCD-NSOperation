//
//  ClosuresViewController.swift
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/4.
//  Copyright © 2023 etlfab. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ClosuresViewController: BaseViewController {
    
    var completionHandlers: [() -> Void] = []
    var x = 10
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.setTitle("CLICK", for: .normal)
        button.backgroundColor = .red
        button.rx.tap
            .subscribe(onNext: {[weak self] in
                
                print("点击--------------------")
                self?.navigationController?.pushViewController(Closure2ViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.left.equalToSuperview().offset(50)
            $0.right.equalToSuperview().offset(-50)
            $0.height.equalTo(30)
        }
        
        commonClosure()
        //不使用尾随闭包进行调用
        let incrementByTen = makeIncrement(forIncrement: 10)
        let incrementBySevent = makeIncrement(forIncrement: 7)
        incrementByTen()
        incrementByTen()
        print(incrementByTen())
        print(incrementBySevent())
        
        someFunctionWithEscpationClosure {
            self.x = 100
        }
        completionHandlers.first?()
        print("-----x:\(x)")
        someFuncationWithNoneEscapingClosure(closure: {
            x = 200
        })
        print("-----x2:\(x)")
        
        //自动闭包
        //---如果传入true
        debugOutPrint(true, doSomething())
        //----打印结果
        //doSomething
        //debug: Network Error Occured
        
        print("我是分割线------------------")
        //---如果传入false
        debugOutPrint(false, "error")
        //---打印结果
        //doSomething
        
    }
    
    //闭包定义
    //    {(parameter) -> return(Type) in
    //       实现
    //    }
    func commonClosure() {
        let divide = {(val1: Int,val2:Int) -> Int in
            return val1 / val2
        }
        let result = divide(200,20)
        print(result)
    }
    
    //尾随闭包
    func trailingClosure(closure:() -> Void) {
        //函数主体部分
    }
    
    //闭包捕获值
    func makeIncrement(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0;
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }
    
    //逃逸闭包
    func someFunctionWithEscpationClosure(completionHandle: @escaping () -> Void) {
        completionHandlers.append(completionHandle)
    }
    
    func someFuncationWithNoneEscapingClosure(closure: () -> Void) {
        closure()
    }
    
    //自动闭包
    //    func debugOutPrint(_ condition: Bool, _ message: String){
    //        if condition {
    //            print("debug: \(message)")
    //        }
    //    }
    
//    func debugOutPrint(_ condition: Bool, _ message: () -> String) {
//        if(condition) {
//            print("debug: \(message())")
//        }
//    }
    
    func debugOutPrint(_ condition: Bool, _ message: @autoclosure () -> String) {
        if(condition) {
            print("debug: \(message())")
        }
    }
    func doSomething() -> String{
        print("doSomething")
        return "Network Error Occured"
    }
    
    
}
