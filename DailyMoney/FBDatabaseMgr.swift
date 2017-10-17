//
//  FBDatabaseMgr.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 10/10/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//
import Foundation
import FirebaseDatabase

class FBDatabaseMgr {
    
    static func fb_user_add(user:String,pass:String,special:String){
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        let u = ["username":user,"password":pass,"special":special]
        
        ref.child("USER").childByAutoId().setValue(u)
    }
    
    static func fb_user_signin(user:String,pass:String)->Bool{
        
        var ref: DatabaseReference!
        var bCheck:Bool = false
        
        ref = Database.database().reference()
        ref.child("USER").observe(.childAdded, with: { (snapshot) in
            let users = snapshot.value as? NSDictionary
            let username:String = users?["username"] as! String
            let password:String = users?["password"] as! String
            
            if user == username && pass == password{
                bCheck = true
            }
        })
//        ref = Database.database().reference(fromURL: "USER").queryEqual(toValue: <#T##Any?#>)
        
        
        return bCheck
    }
}
