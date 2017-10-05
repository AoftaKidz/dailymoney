//
//  TodayViewController.swift
//  DailyWidget
//
//  Created by Narongsak Phungdee on 10/4/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate,UITableViewDataSource {
    
    var currentDate:String = ""
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var reports:[ReportModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reload()
    }
    
    var widgetHeight:CGFloat = 200
    
    func reload(){
        if #available(iOSApplicationExtension 10.0, *) {
            extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        } else {
            // Fallback on earlier versions
        }
        
         currentDate = Utility.currentDate()
        let reportDate = Utility.getDataFromUserDefault(forKey: "currentDate")
        if currentDate == reportDate{
            self.lbTitle.textColor = UIColor.green
            reports = Utility.getDailyReportFromUserDefault()
            
            var sum:Float = 0
            for r in reports{
                
                let amount:Float = Float(r.amount)
                sum = sum + amount
            }
            
            let sumMonthly = Utility.getDataFromUserDefault(forKey: "summaryMonthly")
            lbTitle.text = "รายวัน : \(sum) บาท, รายเดือน : \(sumMonthly) บาท"
            
            let count:Int = reports.count
            widgetHeight = CGFloat(50 + 50*count + 8 + 50)
        }else{
            reports = []
            
            let sumMonthly = Utility.getDataFromUserDefault(forKey: "summaryMonthly")
            lbTitle.text = "รายวัน : 0 บาท, รายเดือน : \(sumMonthly) บาท"

        }
        
        self.tableView.reloadData()
        
    }
    
    func updateSize(){


        var preferredSize = self.preferredContentSize
        preferredSize.height = widgetHeight
        self.preferredContentSize = preferredSize
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

//        updateSize()
        completionHandler(NCUpdateResult.newData)
        
    }
    
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
//        let expanded = activeDisplayMode == .expanded
        
//        preferredContentSize = expanded ? CGSize(width: maxSize.width, height: 110) : maxSize
        
        if activeDisplayMode == NCWidgetDisplayMode.compact{
            self.preferredContentSize = CGSize(width: maxSize.width, height: 110)
        }
        else{
            self.preferredContentSize = CGSize(width: maxSize.width, height: widgetHeight)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = UIFont(name: "Arial Hebrew", size: 16) // change it according to ur requirement
        header?.textLabel?.textColor = UIColor.yellow // change it according to ur requirement
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var dateArray = currentDate.components(separatedBy: "-")
        let m = Utility.calMonthByDate(date: currentDate)
        let d = Utility.calDayByDate(date: currentDate)
        let monthName = Utility.monthNameTH(index: m-1)
        return "\(d) \(monthName) \(dateArray[2])"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WidgetCell", for: indexPath) as! WidgetCell
        
        let r = reports[indexPath.row]
        cell.lbAmount.text = "\(r.amount) บาท"
        cell.lbTitle.text = r.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
