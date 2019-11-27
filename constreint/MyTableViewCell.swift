//
//  MyTableViewCell.swift
//  constreint
//
//  Created by iStaff on 11/21/19.
//  Copyright © 2019 iStaff. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var la2: UILabel!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        lab.text = "11111111111111"
//        la2.text = "222"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        lab.text = "11111111111111"
//        la2.text = "222"

        // Configure the view for the selected state
    }
    

}
