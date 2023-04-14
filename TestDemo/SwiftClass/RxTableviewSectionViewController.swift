//
//  RxTableviewSectionViewController.swift
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/14.
//  Copyright © 2023 etlfab. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxTableviewSectionViewController: BaseViewController {

    let disposeBag = DisposeBag()
    var sectionTableView: UITableView!
    var sectionData = SectionData()
    let resUedId = "RxTabviewCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "组tableview"
        createTableview()
        bindModel()
        RxTableEvent()

    }
}

extension RxTableviewSectionViewController: UITableViewDelegate {
    func createTableview() {
        sectionTableView = UITableView(frame: self.view.bounds, style: .plain)
        let nib = UINib.init(nibName: "RxTabviewCell", bundle: nil)
        sectionTableView.register(nib, forCellReuseIdentifier: resUedId)
        sectionTableView.delegate = self
        self.view.addSubview(sectionTableView)
    }
    
    func bindModel() {
        let datas = RxTableViewSectionedReloadDataSource<SectionModel<String, SectionDataModel>> { (dataSource, tab, indexPath, item) -> RxTabviewCell in
            let cell: RxTabviewCell = tab.dequeueReusableCell(withIdentifier: self.resUedId) as! RxTabviewCell
            cell.firstLabel?.text = item.firstName
            cell.secondLabel?.text = item.secondName
            return cell
        } titleForHeaderInSection: { (dataSource, index) -> String? in
            return dataSource.sectionModels[index].model
        }
        
        sectionData.sectionArr.asDriver(onErrorJustReturn: [])
            .drive(sectionTableView.rx.items(dataSource: datas))
            .disposed(by: disposeBag)
    }
    
    func RxTableEvent() {
        sectionTableView.rx.modelSelected(SectionDataModel.self).subscribe { [weak self](model) in
            print("modelSelected触发了cell点击，\(model)")
        }.disposed(by: disposeBag)

        sectionTableView.rx.itemDeleted.subscribe(onNext: {index in
            print(index)
        })
        .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
