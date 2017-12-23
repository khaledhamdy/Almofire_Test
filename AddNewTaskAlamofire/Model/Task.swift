//
//  Task.swift
//  AddNewTaskAlamofire
//
//  Created by MAC on 12/22/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import SwiftyJSON

class Task:NSObject,NSCopying
{
    var id:Int
    var task:String
    var completed:Bool = false
    
    init(id:Int = 0,task:String)
    {
        self.id = id
        self.task = task
    }
    
    init?(dict:[String:JSON])
    {
        guard let id = dict["id"]?.int,let task = dict["task"]?.string,let completed = dict["completed"]?.toBool else {return nil}
        
        self.id = id
        self.task = task
        self.completed = completed
    }
    
    func copy(with zone: NSZone? = nil) -> Any
    {
        let copiedTask = Task(id: self.id, task: self.task)
        copiedTask.completed = self.completed
        return copiedTask
    }
}
