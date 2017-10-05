//
//  Utility.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 9/30/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    static var widgetReport:[ReportModel] = []
    
    static func currentDate()->String{
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        print(result)
        
        return result
    }
    
    static func currentTime()->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let result = formatter.string(from: date)
        print(result)
        
        return result
    }
    
    static func calDayByDate(date:String)->Int{
        
        var dateArray = date.components(separatedBy: "-")
        let letters = dateArray[0].characters.map { String($0) }
        
        if letters[0] == "0"{
            
            let days = Int(letters[1])!
            return days
            
        }else{
            let days = Int(dateArray[0])!
            return days
        }
    }
    
    static func calMonthByDate(date:String)->Int{
        
        var dateArray = date.components(separatedBy: "-")
        let letters = dateArray[1].characters.map { String($0) }
        
        if letters[0] == "0"{
            
            let m = Int(letters[1])!
            return m
            
        }else{
            let m = Int(dateArray[1])!
            return m
        }
    }
    
    static func monthNameTH(index:Int)->String{
        let monthArray = ["มกราคม","กุมภาพันธ์","มีนาคม","เมษายน","พฤษภาคม","มิถายน","กรกฎาคม","สิงหาคม","กันยายน","ตุลาคม","พฤศจิกายน","ธันวาคม"]

        return monthArray[index]
    }
    
    static func underlineLabel(label:UILabel){
        let text = label.text
        let textRange = NSMakeRange(0, (text?.characters.count)!)
        let attributedText = NSMutableAttributedString(string: text!)
        attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
        // Add other attributes if needed
        label.attributedText = attributedText
    }
    
    static func underlineButton(button:UIButton){
        
        let text = button.titleLabel?.text
        
        let yourAttributes : [String: Any] = [NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue]
        
        let attributeString = NSMutableAttributedString(string: text!,
                                                        attributes: yourAttributes)
        button.setAttributedTitle(attributeString, for: .normal)
        
    }
    
    static func saveReportToUserDefault(reports:[ReportModel]){
    
        let share:UserDefaults = UserDefaults(suiteName: "group.dataGobalTest")!
        
        var reportString:String = ""
        
        for r in reports{
            if reportString == ""{
                reportString = "\(r.title)=\(r.amount)"
            }else{
                reportString = "\(reportString),\(r.title)=\(r.amount)"
            }
        }
        print(reportString)
        share.set(reportString, forKey: "dailyReport")
        share.synchronize()
//
    }
    
    static func getDailyReportFromUserDefault()->[ReportModel]{
        let share:UserDefaults = UserDefaults(suiteName: "group.dataGobalTest")!
//        share.synchronize()
        
        var dailyReport:[ReportModel] = []
        
        if let reportString = share.string(forKey: "dailyReport") {
            
            let titleArray = reportString.components(separatedBy: ",")
            for title in titleArray{
                let amountArray = title.components(separatedBy: "=")
                
                let model = ReportModel()
                model.title = amountArray[0]
                model.amount = Float(amountArray[1])!
                
                dailyReport.append(model)
            }
        }
        
        return dailyReport
    }
    
    static func saveDataToUserDefault(value:String, forKey defaultName:String){
        let share:UserDefaults = UserDefaults(suiteName: "group.dataGobalTest")!
        share.set(value, forKey: defaultName)
        share.synchronize()
    }
    
    static func getDataFromUserDefault(forKey defaultName:String)->String{
        let share:UserDefaults = UserDefaults(suiteName: "group.dataGobalTest")!
        if let value = share.string(forKey: defaultName){
            return value
        }
        return "0"
    }
}
