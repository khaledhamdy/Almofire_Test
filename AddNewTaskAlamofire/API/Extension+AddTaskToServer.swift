//
//  Extension+AddTaskToServer.swift
//  AddNewTaskAlamofire
//
//  Created by MAC on 12/22/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension API
{
    class func AddTaskAPI(task:String,complition:@escaping (_ error:Error?,_ newtask:Task?)->Void)
    {
        guard let api_token = helper.get_Token() else {
            return
        }
        
        let param = ["api_token":api_token,"task":task]
        Alamofire.request(URLs.new_task, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result
            {
            case .success(let value):
                
                let json = JSON(value)
                print(json)
                guard let task = json["task"].dictionary else {return}
                guard let taskObJ = Task(dict: task) else {return}
                complition(nil, taskObJ)
                
            case .failure(let error):
                print(error.localizedDescription)
                complition(error, nil)
            }
        }
    }
}
