//
//  ContentViewVC.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 9/27/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import UIKit

class ContentViewVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!

    static var dataLists:[ReportModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
        
        loadDataFromPlist()
//        self.tableView.reloadData()
        
    }

    func loadDataFromPlist(){
        if let path = Bundle.main.path(forResource: "Reports", ofType: "plist") {
            if let reports = NSArray(contentsOfFile: path) as? [Dictionary<String, String>] {
                
                for r in reports{
                    
                    let model:ReportModel = ReportModel()
                    
                    model.title = r["title"]!
                    let am:String = r["amount"]!
                    model.amount = Float(am)!
                    
                    ContentViewVC.dataLists.append(model)
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func OKBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AddTableReportVC.dataLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        var cell:ReportCell
//        
//        cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as! ReportCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as! ReportCell
        
        let report = ContentViewVC.dataLists[indexPath.row]
        cell.lbTitle.text = report.title
        cell.tfAmount.text = "\(report.amount)"
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
