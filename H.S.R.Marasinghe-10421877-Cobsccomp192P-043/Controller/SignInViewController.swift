//
//  SignInViewController.swift
//  H.S.R.Marasinghe-10421877-Cobsccomp192P-043
//
//  Created by Heshan on 4/15/21.
//  Copyright © 2021 Heshan. All rights reserved.
//

import UIKit
import Firebase
import Loaf

class SignInViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    

    @IBAction func onSIgnInPressed(_ sender: UIButton) {
        
        if !InputValidator.isValidEmail(email: txtEmail.text ?? ""){
            Loaf("Invalid Email Address!!", state: .error, sender: self).show()
            return
        }
        
        if !InputValidator.isValidPassword(pass: txtpassword.text ?? "",
                                          minLength: 6, maxLength: 50){
            Loaf("Invalid Password!!", state: .error, sender: self).show()
            return
        }
        
        authenticateUser(email: txtEmail.text!, password: txtpassword.text!)
    }
    
    
        func authenticateUser(email:String, password: String){
            Auth.auth().signIn(withEmail: email, password: password) {
                authResult, error in

                if let err = error{
                    print(err.localizedDescription)
                    Loaf("Invalid UserName or Password!!", state: .error, sender: self).show()
                    return
                }
                
                if let email = authResult?.user.email{
                    self.getUserData(email: email)
                } else {
                    Loaf("No User Email Found!!", state: .error, sender: self).show()
                }
                
            }
        }
    
        
         func getUserData(email: String) {
                ref.child("users").child(email
                    .replacingOccurrences(of: "@", with: "_")
                    .replacingOccurrences(of: ".", with: "_")).observe(.value, with: {
                    (snapshot) in
                            
                         if snapshot.hasChildren(){
                                
                                if let data = snapshot.value{
                                    if let userData = data as? [String: String]
                                    {
                                        let user = User(
                                            userName: userData["userName"]!,
                                            userEmail: userData["userEmail"]!,
                                            userPassword: userData["userPassword"]!,
                                            userPhone: userData["userPhone"]!)
                                        
                                        //Save user LoggedIn State
                                      let sessionMGR = SessionManager()
                                        sessionMGR.saveUserLogin(user: user)
                                        
                                      self.performSegue(withIdentifier: "SignInToHome", sender: nil)
                                    }
                                }
                                
                            } else {
                            Loaf("No User Found!!", state: .error, sender: self).show()
                        }
                })
          }
        
    }
