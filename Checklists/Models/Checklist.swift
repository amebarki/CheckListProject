//
//  Checklist.swift
//  Checklists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation

class Checklist: Codable
{
    var text: String
    var items = [ChecklistItem]()

    init(text: String, paramItems: [ChecklistItem] = []) {
        self.text = text
        print(self.text)
        print(paramItems.count)
        items = paramItems
    }
    
}
