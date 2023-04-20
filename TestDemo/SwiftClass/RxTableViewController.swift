//
//  RxTableViewControllTerViewController.swift
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/14.
//  Copyright © 2023 etlfab. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import RxDataSources

class RxTableViewController: BaseViewController {
    
    
    let disposeBag = DisposeBag()
    let resUedId = "RxTabviewCell"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView();
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        let nib = UINib.init(nibName: "RxTabviewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: resUedId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "rxtableview"
        bindViewModel()
        RxTableEvent()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

extension RxTableViewController: UITableViewDelegate {
    func bindViewModel() {
        
        let items = Observable.just(RxTableModel().arr)
        items.bind(to: self.tableView.rx.items){(tab, row, item) -> UITableViewCell in
            let cell: RxTabviewCell = tab.dequeueReusableCell(withIdentifier: self.resUedId) as! RxTabviewCell
            cell.firstLabel?.text = item.descStr
            cell.secondLabel?.text = item.numStr
            return cell
        }
        .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect.zero)
        label.text = "123"
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.darkGray
        label.alpha = 0.9
        
        return label
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func RxTableEvent() {
        tableView.rx.modelSelected(DataModel.self).subscribe { [weak self](model) in
            print("modelSelected触发了cell点击，\(model)")
        }.disposed(by: disposeBag)
        
        tableView.rx.itemDeleted.subscribe(onNext: {index in
            print(index)
        })
        .disposed(by: disposeBag)
        
    }
}
