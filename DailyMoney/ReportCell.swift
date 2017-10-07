//
//  ReportCell.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 9/27/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import UIKit

class ReportCell: UITableViewCell {

    @IBOutlet weak var lbCurrentAmount: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
