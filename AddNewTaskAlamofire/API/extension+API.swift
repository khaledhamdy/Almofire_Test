//
//  extension+API.swift
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
    class func taskAPI(page:Int = 1,complition:@escaping (_ error:Error?,_ task:[Task]?,_ last_page:Int)->Void)
    {
        guard let api_token = helper.get_Token() else {
            return
        }
        let param = ["api_token":api_token,"page":page] as [String : Any]
        
        Alamofire.request(URLs.tasks, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result
            {
                
            case .success(let value):
                let json = JSON(value)
                print(json)
                guard let dataArr = json["data"].array else {return}
                var taskArr = [Task]()
                for dataDic in dataArr
                {
                    guard let datadic = dataDic.dictionary,let taskOBJ = Task(dict: datadic) else {return}
                    taskArr.append(taskOBJ)
                }
                let last_page = json["last_page"].int ?? 0
                complition(nil, taskArr, last_page)
            case .failure(let error):
                print(error.localizedDescription)
                complition(error, nil,page )
            }
        }
    }
}






















