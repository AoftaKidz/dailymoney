//
//  DatabaseMgr.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 9/27/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import Foundation
import RealmSwift

class DBReportTable:Object {
    dynamic var specialusername = ""
    dynamic var date = ""//ddmmyy -> 20-09-2560
    dynamic var time = ""//H:M:S -> 20:30
    dynamic var title = ""
    dynamic var amount = ""
}

class DBUser:Object {
    dynamic var username = ""
    dynamic var password = ""
    dynamic var specialkey = ""
}

class DBExpense:Object{
    dynamic var specialusername = ""
    dynamic var title = ""
    dynamic var amount = ""
}

class DatabaseMgr {
    
//    static let username:String = "Nuchkamol"
//    static let password:String = "1234"
//    static let specialKey:String = "#25"
    static let username:String = "KidRock"
    static let password:String = "46215720"
//    static let username:String = "JumJimYaiMai"
//    static let password:String = "1234"
//    static let username:String = "Tatimii"
//    static let password:String = "1234"
    static let specialKey:String = "#14"
    static var isReadyToGo:Bool = false
    
    static let realm = try! Realm()

    static func defaultUser(){
        if isReadyToGo == true{
            return
        }
        
        let user:DBUser = DBUser()
        user.username = username
        user.password = password
        user.specialkey = specialKey
        
        let results = realm.objects(DBUser.self).filter("username == '\(username)' AND password == '\(password)'")
        
        if results.count == 0 {
            try! DatabaseMgr.realm.write {
                //Add new user.
                DatabaseMgr.realm.add(user)
            }
        }else{
            isReadyToGo = true
        }
    }
    
    static func signin(user:String,pass:String)->Bool{
        let u:DBUser = DBUser()
        u.username = user
        u.password = pass
        u.specialkey = ""
        
        let results = realm.objects(DBUser.self).filter("username == '\(user)' AND password == '\(pass)'")
        if results.count > 0{
            return true
        }
        
        return false
    }
    
    static func add(datas:[ReportModel],date:String = Utility.currentDate()){
        
//        let date = Utility.currentDate()
        let time = Utility.currentTime()
        
        for model in datas{
            let dbObject:DBReportTable = DBReportTable()
            
            dbObject.date = date
            dbObject.time = time
            dbObject.specialusername = "\(username)#\(specialKey)"
            dbObject.title = model.title
            dbObject.amount = "\(model.amount)"
            
            let results = realm.objects(DBReportTable.self).filter("date == '\(date)' AND specialusername == '\(username)#\(specialKey)' AND title == '\(model.title)'")

            if results.count == 0{
                try! DatabaseMgr.realm.write {
                    //Add new report.
                    DatabaseMgr.realm.add(dbObject)
                }
            }else{
                try! DatabaseMgr.realm.write {
                    //Add new report.
                    for c in results {
                        c.amount = "\(model.amount)"
                    }
                }
            }
        }
    }
    
    static func delete(datas:[ReportModel],date:String = Utility.currentDate()){
        for model in datas{
            let results = realm.objects(DBReportTable.self).filter("date == '\(date)' AND specialusername == '\(username)#\(specialKey)' AND title == '\(model.title)'")
            if results.count > 0{
                try! DatabaseMgr.realm.write {
                    //delete expense
                    DatabaseMgr.realm.delete(results)
                }
            }
        }
    }
    
    static func dailyReports(date:String = Utility.currentDate())->[ReportModel]{
        
        var r:[ReportModel] = []
        
        let results = realm.objects(DBReportTable.self).filter("date == '\(date)' AND specialusername == '\(username)#\(specialKey)'")
        if results.count > 0{
            for m in results{
                let model = ReportModel()
                model.title = m.title
                model.amount = Float(m.amount)!
                r.append(model)
            }
        }
       
        return r
    }
    
    static func monthlyReports(date:String = Utility.currentDate())->[ReportModel]{
        
        var monthly:[ReportModel] = []
        let dateArray = date.components(separatedBy: "-")
        let countDays = Utility.calDayByDate(date: date)
        for day in 1...countDays{
            
            var newDay = ""
            if day < 10{
                newDay = "0\(day)"
            }else{
                newDay = "\(day)"
            }
            
            let currDate = "\(newDay)-\(dateArray[1])-\(dateArray[2])"
            
            let results = realm.objects(DBReportTable.self).filter("date == '\(currDate)' AND specialusername == '\(username)#\(specialKey)'")
            if results.count > 0{
                var sumAmount:Float = 0.0
                for c in results{
                    let amount = Float(c.amount)!
                    sumAmount += amount
                }
                let report:ReportModel = ReportModel()
                report.title = currDate
                report.amount = sumAmount
                monthly.append(report)
            }else{
                continue
//                let report:ReportModel = ReportModel()
//                report.title = currDate
//                report.amount = 0
//                monthly.append(report)
            }
            
        }
        
        return monthly
    }
    
//    static func yearReports(date:String = Utility.currentDate()){
//        var yearly:[ReportModel] = []
//        let dateArray = date.components(separatedBy: "-")
//        let y:String = dateArray[2]
//        
//        let results = realm.objects(DBReportTable.self).filter("date == '%\(y)' AND specialusername == '\(username)#\(specialKey)' AND ")
//
//    }
    
    static func getExpense()->[ReportModel]{
        
        let specialusername = "\(username)#\(specialKey)"
        let results = realm.objects(DBExpense.self).filter("specialusername == '\(specialusername)'")
        
        var reportExpense:[ReportModel] = []
        
        if results.count > 0 {
            for expense in results{
                let m:ReportModel = ReportModel()
                m.title = expense.title
                m.amount = Float(expense.amount)!
                reportExpense.append(m)
            }
        }
        
        return reportExpense
    }
    
    static func addExpense(title:String, amount:String){
        
        let expense:DBExpense = DBExpense()
        expense.specialusername = "\(username)#\(specialKey)"
        expense.title = title
        expense.amount = amount
        
        let results = realm.objects(DBExpense.self).filter("specialusername == '\(expense.specialusername)' AND title == '\(title)'")
        
        if results.count == 0 {
            try! DatabaseMgr.realm.write {
                //Add new user.
                DatabaseMgr.realm.add(expense)
            }
        }else{
            for c in results {
                c.amount = amount
            }
        }
    }
    
    static func deleteExpense(title:String){
        
        let specialusername = "\(username)#\(specialKey)"
        let results = realm.objects(DBExpense.self).filter("specialusername == '\(specialusername)' AND title == '\(title)'")
        
        if results.count > 0 {
            try! DatabaseMgr.realm.write {
                //delete expense
                DatabaseMgr.realm.delete(results)
                
            }
        }
    }
}
