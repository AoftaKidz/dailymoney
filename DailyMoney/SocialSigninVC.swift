//
//  SocialSigninVCViewController.swift
//  DailyMoney
//
//  Created by Narongsak Phungdee on 10/11/2560 BE.
//  Copyright © 2560 Narongsak Phungdee. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class SocialSigninVC: UIViewController,FBSDKLoginButtonDelegate {

    @IBOutlet weak var btnSignin: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnSignin.readPermissions = ["email","public_profile"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleCustomFBSignin(_ sender: Any) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
            if error != nil{
                print("Custom facebook login failed : ",error!)
                return
            }
            
            self.getFBProfile()
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout")
        firebaseSignOut()
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil{
            print("Graph request error : ",error!)
            return
        }
        
        getFBProfile()
    }
    
    func getFBProfile(){
        
        signinFirebaseWithFacebook()
        
            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email,picture.type(large)"]).start { (connection, result, error) in
                if error != nil{
                    print("Graph request error : ",error!)
                    return
                }
                
                print(result!)
        }
    }
    
    func signinFirebaseWithFacebook(){
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    // ...
                    print("Firebase sign in with facebook failed : ",error)
                    return
                }
                // User is signed in
                // ...
            
                print("Firebase sign in with facebook success : ")
            
            }
    }

    func firebaseSignOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
