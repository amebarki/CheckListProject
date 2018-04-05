//
//  DataModel.swift
//  Checklists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation

class DataModel {
    
    var lists = [Checklist]()

    static let instance = DataModel()
    
    
    var documentDirectory: URL {
        let fm = FileManager.default
        return try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    var dataFileUrl : URL {
        return documentDirectory.appendingPathComponent("checklist").appendingPathExtension("json")
    }
    
    
    init()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(saveChecklist), name: .UIApplicationDidEnterBackground, object: nil)
    }
    
    
    
        
    @objc func saveChecklist()
    {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(lists)
        try! data.write(to: dataFileUrl)
        //print(String(data: data, encoding: .utf8)!)
    }
    
    func loadChecklist()
    {
        let jsonData = try! Data(contentsOf: dataFileUrl, options: .alwaysMapped)
        let decoder = JSONDecoder()
        let data = try! decoder.decode([Checklist].self, from: jsonData)
        for checklist in data {
            lists.append(checklist)
        }
    }
    
}

