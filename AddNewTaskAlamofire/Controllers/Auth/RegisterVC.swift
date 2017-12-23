//
//  RegisterVC.swift
//  AddNewTaskAlamofire
//
//  Created by MAC on 12/19/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController
{
    @IBOutlet var txtRePass: UITextField!
    @IBOutlet var txtPass: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtName: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    @IBAction func RegisterAction(_ sender: UIButton)
    {
        guard let email = txtEmail.text?.trimmed,!email.isEmpty,
        let pass = txtPass.text,!pass.isEmpty,
        let repass = txtRePass.text,!repass.isEmpty,
        let name = txtName.text?.trimmed,!name.isEmpty
        else {return}
        
        API.RegisterAPI(email: email, pass: pass, name: name) { (error:Error?, success:Bool?) in
            if success!{
                print("Success Registerition")
            }else
            {
                print("Error In Registerition")
            }
        }
    }
}









