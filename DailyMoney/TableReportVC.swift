//
//  TableReportVC.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 9/26/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import UIKit

class TableReportVC: UITableViewController {

    var dataLists:[ReportModel] = []
    var dailyReports:[ReportModel] = []
    var monthlyReports:[ReportModel] = []
    
    var currentDate:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentDate = "30-09-2560"//Utility.currentDate()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.font = UIFont(name: "Arial Hebrew", size: 16) // change it according to ur requirement
        header?.textLabel?.textColor = UIColor.yellow // change it according to ur requirement
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return dailyReports.count
        }else{
            return monthlyReports.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:ReportCell
        
        if indexPath.section == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as! ReportCell
            let report:ReportModel = dailyReports[indexPath.row]
            cell.lbTitle.text = report.title
            cell.lbAmount.text = "\(report.amount)"
            cell.lbTitle.textColor = UIColor.white
            cell.lbAmount.textColor = UIColor.white
            
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as! ReportCell
            let reverseDay = monthlyReports.count - indexPath.row - 1
            let report:ReportModel = monthlyReports[reverseDay]
            cell.lbTitle.text = report.title
            cell.lbAmount.text = "\(report.amount)"
            
            if currentDate == report.title{
                cell.lbTitle.textColor = UIColor.green
                cell.lbAmount.textColor = UIColor.green
            }else{
                cell.lbTitle.textColor = UIColor.white
                cell.lbAmount.textColor = UIColor.white
            }
        }

        return cell
    }
 
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
//            let date = Date()
//            let calendar = Calendar.current
//            
//            let year = calendar.component(.year, from: date)
//            let month = calendar.component(.month, from: date)
//            let monthName = Utility.monthNameTH(index: month-1)
//            let day = calendar.component(.day, from: date)
//            return "\(day) \(monthName) \(year)"
            var dateArray = currentDate.components(separatedBy: "-")
            let m = Utility.calMonthByDate(date: currentDate)
            let d = Utility.calDayByDate(date: currentDate)
            let monthName = Utility.monthNameTH(index: m-1)
            return "\(d) \(monthName) \(dateArray[2])"
            
        }else{
//            let date = Date()
//            let calendar = Calendar.current
//            
//            let year = calendar.component(.year, from: date)
//            let month = calendar.component(.month, from: date)
//            let monthName = Utility.monthNameTH(index: month-1)
////            let day = calendar.component(.day, from: date)
//            return "\(monthName) \(year)"
            var dateArray = currentDate.components(separatedBy: "-")
            let m = Utility.calMonthByDate(date: currentDate)
            let monthName = Utility.monthNameTH(index: m-1)
            return "\(monthName) \(dateArray[2])"
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
