//
//  SignUpViewController.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/15/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit
import Firebase
import Loaf

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtphone: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    

    @IBAction func onSignInPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSignUpPressed(_ sender: UIButton) {
        
            if !InputValidator.isValidName(name: txtname.text ?? ""){
                Loaf("Invalid Name!!", state: .error, sender: self).show()
                return
            }
        
            if !InputValidator.isValidEmail(email: txtemail.text ?? ""){
                Loaf("Invalid Email Address!!", state: .error, sender: self).show()
                return
            }
            
            if !InputValidator.isValidPassword(pass: txtpassword.text ?? "",
                                              minLength: 6, maxLength: 50){
                Loaf("Invalid Password!!", state: .error, sender: self).show()
                return
            }
            
            if !InputValidator.isValidMobileNo(txtphone.text ?? ""){
                Loaf("Invalid Phone Number!!", state: .error, sender: self).show()
                return
            }

            let user = User(userName: txtname.text ?? "", userEmail: txtemail.text ?? "", userPassword: txtpassword.text ?? "", userPhone: txtphone.text ?? "")
            

            registerUser(user: user)
    }
    
    func registerUser(user: User){
            Auth.auth().createUser(withEmail: user.userEmail, password: user.userPassword)
            { authResult, error in
                if let err = error{
                    print(err.localizedDescription)
                    return
                }
                
                self.saveUserData(user: user)
            }
        }
        
        //Save users to the database
        func saveUserData(user: User){
            
            let userData = [
                "userName" : user.userName,
                "userEmail" : user.userEmail,
                "userPassword" : user.userPassword,
                "userPhone" : user.userPhone,
            ]
            
            self.ref.child("users").child(user.userEmail
                .replacingOccurrences(of: "@", with: "_")
                .replacingOccurrences(of: ".", with: "_")).setValue(userData)
            {
                (error, ref) in //check whether values inserted
               
                if let err = error{
                    print(err)
                    Loaf("User data not saved on database!!", state: .error, sender: self).show()
                    return
                }
                
                Loaf("User Created Successfully!!", state: .success, sender: self).show() {
                    type in
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
}

