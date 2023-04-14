//
//  RxTextViewController.swift
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/12.
//  Copyright © 2023 etlfab. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RxTextViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    var timer: Timer?
    var currentSeconds: Int = 0
    let userNameTextfield = UITextField()
    let passWordTextfield = UITextField()
    let button = UIButton(type: .custom)
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextfield.placeholder = "请输入用户名"
        userNameTextfield.backgroundColor = .red
        view.addSubview(userNameTextfield)
        userNameTextfield.rx.text
            .subscribe { value in
                print("value")
                
            }
            .disposed(by: disposeBag)
        
        
        passWordTextfield.placeholder = "请输入密码"
        passWordTextfield.backgroundColor = .red
        view.addSubview(passWordTextfield)
        
        button.setTitle("CLICK", for: .normal)
        button.backgroundColor = .red
        button.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                    self?.currentSeconds += 1
//                    print(self?.currentSeconds)
                })
                print("点击--------------------")
            })
            .disposed(by: disposeBag)
        view.addSubview(button)
        label.textColor = .red
        view.addSubview(label)
        userNameTextfield.rx.text.bind(to: label.rx.text).disposed(by: disposeBag)
        
        contrans()
    }
    
    func contrans() {
        userNameTextfield.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.equalToSuperview().offset(50)
            $0.right.equalToSuperview().offset(-50)
            
        }
        
        passWordTextfield.snp.makeConstraints{
            $0.top.equalTo(userNameTextfield.snp_top).offset(50)
            $0.left.equalToSuperview().offset(50)
            $0.right.equalToSuperview().offset(-50)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(passWordTextfield).offset(200)
            $0.left.equalToSuperview().offset(50)
            $0.right.equalToSuperview().offset(-50)
            $0.height.equalTo(30)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(button).offset(30)
            $0.left.equalToSuperview().offset(50)
            $0.right.equalToSuperview().offset(-50)
            $0.height.equalTo(30)
        }
    }
    
    // 显示消息提示框
    func showMessage(_ text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    deinit {
        timer?.invalidate()
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        timer?.invalidate()
//        timer = nil
//
//    }
}


