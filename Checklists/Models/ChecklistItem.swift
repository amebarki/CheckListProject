//
//  ChecklistItem.swift
//  Checklists
//
//  Created by iem on 01/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation


class ChecklistItem : Codable
{
    var text: String
    var checked: Bool = false
    
    init(text: String, checked: Bool = false) {
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked() {
        checked = !checked
    }
}
