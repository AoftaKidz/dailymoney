//
//  ChartCell.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 10/1/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import UIKit
import Charts
class ChartCell: UITableViewCell {

    @IBOutlet weak var pieView: PieChartView!
    @IBOutlet weak var barView: BarChartView!
    @IBOutlet weak var lineView: LineChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
