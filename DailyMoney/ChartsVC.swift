//
//  ChartsVC.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 10/1/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import UIKit
import Charts

class ChartsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var currentDate:String = ""
    @IBOutlet weak var tableView: UITableView!
    
    var chartsList:[ChartData] = []
    
    @IBOutlet weak var barChartsContainer: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Text Back
        navigationController!.navigationBar.topItem!.title = ""
        
        //Navigation Title Color
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //Navigation Back Color
        navigationController!.navigationBar.tintColor = UIColor.white
        
        navigationController!.navigationBar.barTintColor = UIColor.black
        
        self.title = "กราฟแสดงรายจ่าย"
        
//        pieChart()
//        lineChart()
//        barChart()
//        dailyChart(chartType: ChartData.CHART_TYPE_BAR)
        monthlyChart(chartType: ChartData.CHART_TYPE_LINE)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dailyChart(chartType:Int = ChartData.CHART_TYPE_LINE){
        
        switch chartType {
        case ChartData.CHART_TYPE_LINE:
            lineChart()
            break
        case ChartData.CHART_TYPE_BAR:
            barChart()
            break
        case ChartData.CHART_TYPE_PIE:
            pieChart()
            break
        default: break
            
        }
    }
    
    func monthlyChart(chartType:Int = ChartData.CHART_TYPE_LINE){
        
        switch chartType {
        case ChartData.CHART_TYPE_LINE:
            
            let monthlyReports = DatabaseMgr.monthlyReports(date: currentDate)
            let cd:ChartData = ChartData()
            var count:Int = 1
            
            for report in monthlyReports{
                
                cd.x.append(Double(count))
                cd.y.append(Double(report.amount))
                count += 1
            }
            
            cd.type = ChartData.CHART_TYPE_LINE
            var dateArray = currentDate.components(separatedBy: "-")
            let m = Utility.calMonthByDate(date: currentDate)
            let monthName = Utility.monthNameTH(index: m-1)
            cd.title = "\(monthName) \(dateArray[2])"
            chartsList.append(cd)
            
            break
        case ChartData.CHART_TYPE_BAR:
            let monthlyReports = DatabaseMgr.monthlyReports(date: currentDate)
            let cd:ChartData = ChartData()
            var count:Int = 1
            
            for report in monthlyReports{
                
                cd.x.append(Double(count))
                cd.y.append(Double(report.amount))
                count += 1
            }
            
            cd.type = ChartData.CHART_TYPE_BAR
            var dateArray = currentDate.components(separatedBy: "-")
            let m = Utility.calMonthByDate(date: currentDate)
            let monthName = Utility.monthNameTH(index: m-1)
            cd.title = "\(monthName) \(dateArray[2])"
            chartsList.append(cd)

            break
        case ChartData.CHART_TYPE_PIE:
            let monthlyReports = DatabaseMgr.monthlyReports(date: currentDate)
            let cd:ChartData = ChartData()
            var count:Int = 1
            
            for report in monthlyReports{
                
                cd.x.append(Double(report.amount))
                cd.label.append(report.title)
                count += 1
            }
            
            cd.type = ChartData.CHART_TYPE_LINE
            var dateArray = currentDate.components(separatedBy: "-")
            let m = Utility.calMonthByDate(date: currentDate)
            let monthName = Utility.monthNameTH(index: m-1)
            cd.title = "\(monthName) \(dateArray[2])"
            chartsList.append(cd)
            break
        default: break
            
        }
    }
    
    func yearChart(){
        
    }
    
    func lineChart(){
        let dailyReports = DatabaseMgr.dailyReports(date: currentDate)
        let cd:ChartData = ChartData()
        var count:Int = 1
        
        for report in dailyReports{
            
            cd.x.append(Double(count))
            cd.y.append(Double(report.amount))
            count += 1
        }
        
        cd.type = ChartData.CHART_TYPE_LINE
        
        var dateArray = currentDate.components(separatedBy: "-")
        let m = Utility.calMonthByDate(date: currentDate)
        let d = Utility.calDayByDate(date: currentDate)
        let monthName = Utility.monthNameTH(index: m-1)
        cd.title = "\(d) \(monthName) \(dateArray[2])"
        
        chartsList.append(cd)
    }
    
    func barChart(){
        let dailyReports = DatabaseMgr.dailyReports(date: currentDate)
        let cd:ChartData = ChartData()
        var count:Int = 1
        
        for report in dailyReports{
            
            cd.x.append(Double(count))
            cd.y.append(Double(report.amount))
            count += 1
        }
        
        cd.type = ChartData.CHART_TYPE_BAR
        var dateArray = currentDate.components(separatedBy: "-")
        let m = Utility.calMonthByDate(date: currentDate)
        let d = Utility.calDayByDate(date: currentDate)
        let monthName = Utility.monthNameTH(index: m-1)
        cd.title = "\(d) \(monthName) \(dateArray[2])"
        chartsList.append(cd)
    }
    
    func pieChart(){
        
       let dailyReports = DatabaseMgr.dailyReports(date: currentDate)
        let cd:ChartData = ChartData()
        
        for report in dailyReports{
            
            cd.x.append(Double(report.amount))
            cd.label.append(report.title)
        }
        
        cd.type = ChartData.CHART_TYPE_PIE
        var dateArray = currentDate.components(separatedBy: "-")
        let m = Utility.calMonthByDate(date: currentDate)
        let d = Utility.calDayByDate(date: currentDate)
        let monthName = Utility.monthNameTH(index: m-1)
        cd.title = "\(d) \(monthName) \(dateArray[2])"
        chartsList.append(cd)
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
        
        let cd = chartsList[section]
        
        return cd.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return chartsList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ChartCell
        
        let cd = chartsList[indexPath.section]
        
        if cd.type == ChartData.CHART_TYPE_PIE{
        
            cell = tableView.dequeueReusableCell(withIdentifier: "pieChartCell", for: indexPath) as! ChartCell
            ChartsMgr.pie(points: cd, view: cell.pieView)
        }else if cd.type == ChartData.CHART_TYPE_LINE{
            cell = tableView.dequeueReusableCell(withIdentifier: "lineChartCell", for: indexPath) as! ChartCell
            ChartsMgr.line(points: cd, view: cell.lineView)
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "barChartCell", for: indexPath) as! ChartCell
            ChartsMgr.bar(points: cd, view: cell.barView)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
}
