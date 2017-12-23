//
//  API.swift
//  AddNewTaskAlamofire
//
//  Created by MAC on 12/19/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API
{
    class func loginAPI(email:String,pass:String,complition:@escaping (_ error:Error?,_ success:Bool?)->Void)
    {
        let param = ["email":email,"password":pass]
        Alamofire.request(URLs.login, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result
            {
            case .success(let value):
                let json = JSON(value)
                print(json)
                if let api_token = json["user"]["api_token"].string
                {
                    helper.save_Token(api_token: api_token)
                }
                complition(nil, true)
            case .failure(let error):
                print(error.localizedDescription)
                complition(error, false)
            }
        }
    }
    
    //For Register
    class func RegisterAPI(email:String,pass:String,name:String,complition:@escaping (_ error:Error?,_ success:Bool?)->Void)
    {
        let param = ["email":email,"password":pass,"name":name,"password_confirmation":pass]
        Alamofire.request(URLs.login, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result
            {
                
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                complition(nil, true)
            case .failure(let error):
                print(error.localizedDescription)
                complition(error, false)
            }
        }
    }
    
}
