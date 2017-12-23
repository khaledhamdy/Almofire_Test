//
//  AppDelegate.swift
//  AddNewTaskAlamofire
//
//  Created by MAC on 12/19/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
       if let get_token = helper.get_Token()
       {
            print("token is \(get_token)")
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main")
            window?.rootViewController = sb
       }
        return true
    }
}
