//
//  Charts.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 10/1/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import Foundation
import Charts

class ChartData {
    static let CHART_TYPE_LINE:Int = 0
    static let CHART_TYPE_BAR:Int = 1
    static let CHART_TYPE_PIE:Int = 2

    var x:[Double] = []
    var y:[Double] = []
    var label:[String] = []
    var title:String = ""
    var description:String = ""
    var type:Int = 0
}

class Charts {
    
    static func line(points:ChartData,view:LineChartView){
        var chartData:[ChartDataEntry] = []
        
        for i in 0...points.x.count{
            
            let p = ChartDataEntry(x: points.x[i], y: points.y[i])
            chartData.append(p)
        }
        
        
        let dataSet = LineChartDataSet(values: chartData, label: points.title)
        let data = LineChartData(dataSets: [dataSet])
        
        view.data = data
        view.chartDescription?.text = points.description
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        view.notifyDataSetChanged()
    }
    
    static func bar(points:ChartData,view:BarChartView){
        
        var chartData:[BarChartDataEntry] = []
        
        for i in 0...points.x.count{
            
            let p = BarChartDataEntry(x: points.x[i], y: points.y[i])
            chartData.append(p)
        }
        
     
        let dataSet = BarChartDataSet(values: chartData, label: points.title)
        let data = BarChartData(dataSets: [dataSet])
        
        view.data = data
        view.chartDescription?.text = points.description
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        view.notifyDataSetChanged()
        
    }
    
    static func pie(points:ChartData,view:PieChartView){
        // Basic set up of plan chart
        var chartData:[PieChartDataEntry] = []
        
        for i in 0...points.x.count{
            
            let p = PieChartDataEntry(value: points.x[i], label: points.label[i])
            chartData.append(p)
        }
        
        let dataSet = PieChartDataSet(values: chartData, label: points.title)
        let data = PieChartData(dataSet: dataSet)
        view.data = data
        view.chartDescription?.text = points.description
        
        // Color
        dataSet.colors = ChartColorTemplates.joyful()
        //dataSet.valueColors = [UIColor.black]
        view.backgroundColor = UIColor.black
        view.holeColor = UIColor.clear
        view.chartDescription?.textColor = UIColor.white
        view.legend.textColor = UIColor.white
        
        // Text
        view.legend.font = UIFont(name: "Futura", size: 10)!
        view.chartDescription?.font = UIFont(name: "Futura", size: 12)!
        view.chartDescription?.xOffset = view.frame.width
        view.chartDescription?.yOffset = view.frame.height * (2/3)
        view.chartDescription?.textAlign = NSTextAlignment.left
        
        // Refresh chart with new data
        view.notifyDataSetChanged()
    }
}
