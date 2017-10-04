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
}
