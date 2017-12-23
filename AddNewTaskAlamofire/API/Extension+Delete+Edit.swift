//
//  Extension+Delete+Edit.swift
//  AddNewTaskAlamofire
//
//  Created by MAC on 12/23/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension API
{
    //For Delete
    class func deleteAPI(task:Task,complition:@escaping (_ error:Error?,_ success:Bool?)->Void)
    {
        guard let api_token = helper.get_Token() else {return}
        
        let param = ["api_token":api_token,"task_id": task.id] as [String : Any]
        
        Alamofire.request(URLs.delete_task, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result
            {
            case .failure(let error):
                print(error.localizedDescription)
                complition(error, false)
            case .success(let value):
                let json = JSON(value)
                print(json)
                complition(nil, true)
           
            }
        }
    }
    
    //For Edit
    class func EditAPI(task:Task,complition:@escaping (_ error:Error?,_ editTask:Task?)->Void)
    {
        guard let api_token = helper.get_Token() else {return}
        
        let param =
            [
            "api_token":api_token,
            "task_id": task.id,
            "task":task.task,
            "completed": task.completed.toInt
            ] as [String : Any]
        
        Alamofire.request(URLs.edit_task, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result
            {
            case .failure(let error):
                print(error.localizedDescription)
                complition(error, nil)
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                guard let task = json["task"].dictionary,let taskOBJ = Task(dict: task) else {return}
                complition(nil, taskOBJ)
                
            }
        }
    }

}
