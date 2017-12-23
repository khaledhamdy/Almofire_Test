//
//  LoginVC.swift
//  AddNewTaskAlamofire
//
//  Created by MAC on 12/19/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit

class LoginVC: UIViewController
{
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPass: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func LoginAction(_ sender: UIButton)
    {
        guard let email = txtEmail.text?.trimmed,!email.isEmpty,let pass = txtPass.text,!pass.isEmpty else {return}
        API.loginAPI(email: email, pass: pass) { (error:Error?, success:Bool?) in
            if success!{
             print("Success Login")
            }else
            {
                print("Error In Login")
            }
        }
    }
}

