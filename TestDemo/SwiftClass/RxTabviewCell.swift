//
//  RxTabviewCell.swift
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/14.
//  Copyright © 2023 etlfab. All rights reserved.
//

import UIKit

class RxTabviewCell: UITableViewCell {

    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func getValue(firstStr: String, secondStr: String) {
        self.firstLabel.text = firstStr
        self.secondLabel.text = secondStr
    }
    
}
