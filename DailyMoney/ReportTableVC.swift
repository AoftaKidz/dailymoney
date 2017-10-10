//
//  ReportTableVC.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 9/28/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import UIKit

class ReportTableVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnExpand: UIButton!
    @IBOutlet weak var viewAddExpenseBG: UIView!
    @IBOutlet weak var constraintHeightAddExpense: NSLayoutConstraint!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnDeleteExpense: UIButton!
    @IBOutlet weak var btnAddExpense: UIButton!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tfExpense: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var dataLists:[ReportModel] = []
    var dailyReports:[ReportModel] = []
    
    var isKeyboardShowing:Bool = false
    var currentDate:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Text Back
        navigationController!.navigationBar.topItem!.title = ""
        
        //Navigation Title Color
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //Navigation Back Color
        navigationController!.navigationBar.tintColor = UIColor.white
        
        navigationController!.navigationBar.barTintColor = UIColor.black
        
        self.title = "รายจ่าย"
        
//        loadDataFromPlist()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ReportTableVC.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ReportTableVC.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        Utility.underlineButton(button: btnOK)
        Utility.underlineButton(button: btnDelete)
        Utility.underlineButton(button: btnAddExpense)
        Utility.underlineButton(button: btnDeleteExpense)
        hideAddExpense()
        reloadDataTable()
    }
    
    @IBAction func buttonExpandAddExpensePressed(_ sender: Any) {
    
        if self.constraintHeightAddExpense.constant == 0{
            showAddExpense()
        }else{
            hideAddExpense()
        }
    }
    
    func showAddExpense(){
        btnExpand.setImage(UIImage(named: "arrow_up"), for: .normal)
        UIView.animate(withDuration: 0.3, animations: {
            self.constraintHeightAddExpense.constant = 120
//            self.viewAddExpenseBG.isHidden = false
                    })
        
    }
    
    func hideAddExpense(){
        btnExpand.setImage(UIImage(named: "arrow_down"), for: .normal)
        UIView.animate(withDuration: 0.3, animations: {
            self.constraintHeightAddExpense.constant = 0
//            self.viewAddExpenseBG.isHidden = true
        })
    }
    
    /**
     * Called when keyboard is showing or hidding
     */
    func keyboardWillShow(_ notification: NSNotification){
        // Do something here
        
        isKeyboardShowing = true
//        self.animateTextField(up: true)
    }
    
    func keyboardWillHide(_ notification: NSNotification){
        // Do something here
        isKeyboardShowing = false
//        self.animateTextField(up: false)
    }
    
    var kbHeight:CGFloat = 210
    
//    func animateTextField(up: Bool) {
//        let movement = (up ? -kbHeight : kbHeight)
//        
//        UIView.animate(withDuration: 0.3, animations: {
//            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
//        })
//    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    var moveKeyboardOffset:CGFloat = 0
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let p = textField.convert(textField.center, to: self.view)
        print(p)
        
        let kbH = self.view.bounds.size.height - kbHeight
        let tfH = p.y + textField.bounds.size.height
        
        if tfH > kbH {
            //TextField overlapping keyboard
            
            moveKeyboardOffset = tfH - kbH + 20
            print(moveKeyboardOffset)
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -self.moveKeyboardOffset)
            })
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: self.moveKeyboardOffset)
        })
        self.moveKeyboardOffset = 0
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
   
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
    @IBAction func addReportBtnPress(_ sender: Any) {
        
        var reports:[ReportModel] = []
        for r in dataLists{
            if r.isSelected{
                r.amount = r.amount+r.currentAmount
                reports.append(r)
            }
        }
        
        DatabaseMgr.add(datas: reports,date: currentDate)
        
        navigationController?.popViewController(animated: true)
    }

    @IBAction func deleteReportBtnPress(_ sender: Any) {
        var reports:[ReportModel] = []
        for r in dataLists{
            if r.isSelected{
                r.currentAmount = 0
                reports.append(r)
            }
        }
        
        DatabaseMgr.delete(datas: reports,date: currentDate)
        reloadDataTable()
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromPlist(){
        if let path = Bundle.main.path(forResource: "Reports", ofType: "plist") {
            if let reports = NSArray(contentsOfFile: path) as? [Dictionary<String, String>] {
                
                for r in reports{
                    
                    let model:ReportModel = ReportModel()
                    
                    model.title = r["title"]!
                    let am:String = r["amount"]!
                    model.amount = Float(am)!
                    
                    dataLists.append(model)
                }
            }
        }
        
    }
    
    func reloadDataTable(){
        
        if dataLists.count > 0{
            dataLists.removeAll()
        }
        
        dataLists = DatabaseMgr.getExpense()
        dailyReports = DatabaseMgr.dailyReports(date: currentDate)
        for expense in dataLists{
            for report in dailyReports{
                if expense.title == report.title{
                    expense.currentAmount = report.amount
                    break
                }
            }
        }
        tableView.reloadData()
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
        return dataLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addReportCell", for: indexPath) as! ReportCell
        
        let report = dataLists[indexPath.row]
        cell.lbTitle.text = report.title
        cell.tfAmount.text = "\(report.amount)"
        cell.tfAmount.delegate = self
        cell.tfAmount.tag = indexPath.row
        cell.tfAmount.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        if report.currentAmount > 0{
            cell.lbCurrentAmount.text = "\(report.currentAmount)"
        }else{
            cell.lbCurrentAmount.text = ""
        }
        
        if report.isSelected == true{
//            cell.accessoryType = .checkmark
            cell.lbTitle.textColor = UIColor.green
            cell.tfAmount.textColor = UIColor.green

        }else{
//            cell.accessoryType = .none
            cell.lbTitle.textColor = UIColor.white
            cell.tfAmount.textColor = UIColor.white

        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isKeyboardShowing==true{
            view.endEditing(true)
            return
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! ReportCell

//        cell?.accessoryType = .checkmark
        cell.lbTitle.textColor = UIColor.green
        cell.tfAmount.textColor = UIColor.green
        
        let report = dataLists[indexPath.row]
        report.isSelected = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if isKeyboardShowing==true{
            view.endEditing(true)
            return
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! ReportCell
        
//        cell?.accessoryType = .none
        cell.lbTitle.textColor = UIColor.white
        cell.tfAmount.textColor = UIColor.white
        
        let report = dataLists[indexPath.row]
        report.isSelected = false
    }
    
    func textFieldDidChange(_ textField: UITextField) {
       
        if textField.text == ""{
            return
        }
        
        dataLists[textField.tag].amount = Float(textField.text!)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addExpenseButtonPress(_ sender: Any) {
        if tfExpense.text == "" {
            return
        }
        
        DatabaseMgr.addExpense(title: tfExpense.text!, amount: tfAmount.text!)
        
        reloadDataTable()
        
    }
    
    @IBAction func deleteExpenseButtonPress(_ sender: Any) {
        
        var checkSomeThing:Bool = false
        
        for r in dataLists{
            if r.isSelected{
                checkSomeThing = true
                DatabaseMgr.deleteExpense(title: r.title)
            }
        }
        
        if checkSomeThing == true{
            reloadDataTable()
        }
    }
    
}
