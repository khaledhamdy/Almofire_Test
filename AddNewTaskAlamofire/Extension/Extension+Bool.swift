//
//  Extension+Bool.swift
//  AddNewTaskAlamofire
//
//  Created by MAC on 12/23/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
extension Bool
{
    var toInt:Int
    {
        return NSNumber(booleanLiteral: self).intValue
    }
}
