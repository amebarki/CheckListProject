//
//  DataModel.swift
//  Checklists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation

class DataModel {
    
    static let instance = DataModel()
    var list: Checklist!
    var documentDirectory: URL {
        let fm = FileManager.default
        return try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    var dataFileUrl : URL {
        return documentDirectory.appendingPathComponent("checklist").appendingPathExtension("json")
    }
    
        
    func saveChecklist(lists: [Checklist])
    {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(lists)
        try! data.write(to: dataFileUrl)
        //print(String(data: data, encoding: .utf8)!)
    }
    
    func loadChecklist() -> [Checklist]
    {
        var lists = [Checklist]()
        let jsonData = try! Data(contentsOf: dataFileUrl, options: .alwaysMapped)
        let decoder = JSONDecoder()
        let data = try! decoder.decode([Checklist].self, from: jsonData)
        for checklist in data {
            lists.append(checklist)
        }
        return lists
    }
    
}

