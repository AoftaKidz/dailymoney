//
//  SigninVC.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 9/30/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import UIKit

class SigninVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var btnSignin: UIButton!
    @IBOutlet weak var lbSigningInHeader: UILabel!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Navigation Title Color
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //Navigation Back Color
        navigationController!.navigationBar.tintColor = UIColor.white
        
        navigationController!.navigationBar.barTintColor = UIColor.black
        self.title = "Daily Money"
        
        tfUsername.text = DatabaseMgr.username
        tfPassword.text = DatabaseMgr.password
        tfPassword.textColor = UIColor.green
        tfUsername.textColor = UIColor.green
        
        tfUsername.delegate = self
        tfPassword.delegate = self
        
        Utility.underlineLabel(label: lbSigningInHeader)
        Utility.underlineButton(button: btnSignin)
        DatabaseMgr.defaultUser()
//        FBDatabaseMgr.fb_user_add(user: DatabaseMgr.username, pass: DatabaseMgr.password, special: DatabaseMgr.specialKey)
//        FBDatabaseMgr.fb_user_add(user: DatabaseMgr.username, pass: DatabaseMgr.password, special: DatabaseMgr.specialKey)
//
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    
    @IBAction func SigninButtonPress(_ sender: Any) {
        
        view.endEditing(true)
        
//        let success = DatabaseMgr.signin(user: tfUsername.text!, pass: tfPassword.text!)
        let success = FBDatabaseMgr.fb_user_signin(user: DatabaseMgr.username, pass: DatabaseMgr.password)

        if success == true{
//            let storyboard = UIStoryboard(name: "ReportTableStoryboard", bundle: nil)
            let vc = storyboard?.instantiateViewController(withIdentifier: "ShowReport") as! ViewController
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let alert = UIAlertController(title: "เข้าบ่ได้เด้อ", message: "อะไรๆ จะแอบเข้ามาดูรึไง.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ปิด", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
