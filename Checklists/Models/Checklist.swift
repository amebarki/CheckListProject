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
    var icon: IconAsset
    
    var uncheckedItemsCount:Int
    {
        return items.filter{item in !item.checked}.count
    }
    
    init(paramText: String, paramItems: [ChecklistItem] = [], paramIcon: IconAsset = IconAsset.NoIcon) {
        self.text = paramText
        print(self.text)
        print(paramItems.count)
        self.items = paramItems
        self.icon = paramIcon
    }
}
