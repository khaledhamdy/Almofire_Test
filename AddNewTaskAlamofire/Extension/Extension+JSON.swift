//
//  Extension+JSON.swift
//  AddNewTaskAlamofire
//
//  Created by MAC on 12/22/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import SwiftyJSON
extension JSON
{
    var toBool:Bool?
    {
        if let bool = self.bool
        {
            return bool
        }
        if let int = self.int
        {
            if int == 0
            {
                return false
            }
            else if int == 1
            {
                return true
            }
        }
        if let string = self.string
        {
            if Int(string) == 0
            {
                return false
            }
            else if Int(string) == 1
            {
                return true
            }
        }
        return nil
    }
    
}
