//
//  ViewController.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 9/26/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import DatePickerDialog

class ViewController: UIViewController {

    var dailyReports:[ReportModel] = []
    var monthlyReports:[ReportModel] = []
    var tableReport:TableReportVC? = nil
    var currentDate:String = "30-09-2560"
    
    @IBOutlet weak var lbSummary: UILabel!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var viewLoginButton: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:true);

        //Text Back
        navigationController!.navigationBar.topItem!.title = "Sign out"
        
        //Navigation Title Color
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //Navigation Back Color
        navigationController!.navigationBar.tintColor = UIColor.white
        
        navigationController!.navigationBar.barTintColor = UIColor.black
        
        self.title = "Daily Money"

        currentDate = Utility.currentDate()
        
//        FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//        loginButton.center = self.view.center;
//        [self.view addSubview:loginButton];
        
//        let loginButton:FBSDKLoginButton = FBSDKLoginButton()
//        viewLoginButton.addSubview(loginButton)
        
//        if (FBSDKAccessToken.current() != nil){
//            
//            viewLoginButton.isHidden = true
//            
//        }else{
//            viewLoginButton.isHidden = false
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        //Navigation Title Color
        //Text Back
        navigationController!.navigationBar.topItem!.title = "Sign out"
        
        //Navigation Title Color
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //Navigation Back Color
        navigationController!.navigationBar.tintColor = UIColor.white
        
        navigationController!.navigationBar.barTintColor = UIColor.black
        
        self.title = "Daily Money"
        
        reload()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueReportTable") {
            tableReport = segue.destination as? TableReportVC
            
            reload()
           
        }
    }
    
    func reload(){
        if let vc = tableReport{
            dailyReports = DatabaseMgr.dailyReports(date: currentDate)
            monthlyReports = DatabaseMgr.monthlyReports(date: currentDate)
            vc.dailyReports = dailyReports
            vc.monthlyReports = monthlyReports
            vc.currentDate = currentDate
            
            vc.tableView.reloadData()
            
            var sumDaily:Float = 0
            var sumMonthly:Float = 0
            for d in dailyReports{
                sumDaily += d.amount
            }
            
            for d in monthlyReports{
                sumMonthly += d.amount
            }
            
            lbSummary.text = "รายวัน : \(sumDaily) บาท, รายเดือน : \(sumMonthly) บาท"
            lbSummary.textColor = UIColor.green
        }
        
    }
    
    @IBAction func calendarBtnPress(_ sender: Any) {
        DatePickerDialog().show("เลือกวันที่", doneButtonTitle: "ตกลง", cancelButtonTitle: "ยกเลิก", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                self.currentDate = formatter.string(from: dt)
                self.reload()
            }
        }
    }
    
    @IBAction func addReportBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "ReportTableStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ReportTable") as! ReportTableVC
        vc.currentDate = currentDate
        navigationController?.pushViewController(vc, animated: true)
        
//        if let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewVC") as? ContentViewVC {
//            navigationController?.pushViewController(vc3, animated: true)
////            
////            let appDelegate = UIApplication.shared.delegate as! AppDelegate
////            appDelegate.window?.rootViewController!.present(vc3, animated: true, completion: nil)
//        }
    }

    @IBAction func chartBtnPress(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ChartsStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChartsVC") as! ChartsVC
        vc.currentDate = currentDate
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

