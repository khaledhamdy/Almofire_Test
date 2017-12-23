//
//  Extension+String.swift
//  AddNewTaskAlamofire
//
//  Created by MAC on 12/19/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
extension String
{
    var trimmed:String?
    {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
