//
//  helper.swift
//  AddNewTaskAlamofire
//
//  Created by MAC on 12/19/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import UIKit
class helper
{
    class func save_Token(api_token:String)
    {
        let def = UserDefaults.standard
        def.set(api_token, forKey: "api_token")
        def.synchronize()
        restartApp()
    }
    
    class func restartApp()
    {
        let window = UIApplication.shared.keyWindow
        
        if get_Token() == nil
        {
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
        else
        {
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main")
            UIView.transition(with: window!, duration: 0.44, options: .transitionCurlUp, animations: nil, completion: nil)
        }
    }
    
    class func get_Token()->String?
    {
        let def = UserDefaults.standard
        return def.object(forKey: "api_token") as? String
    }
}
