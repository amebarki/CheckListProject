//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

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

var table = [ChecklistItem]()
var documentDirectory: URL?
var dataFileUrl : URL?

let fm = FileManager.default
documentDirectory = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
print(documentDirectory?.absoluteString ?? "No Path")
dataFileUrl = documentDirectory?.appendingPathComponent("checklist").appendingPathExtension("json")
print(dataFileUrl?.absoluteString ?? "Path not created")


let item0 = ChecklistItem(text:"Katakuri",checked:true)
let item1 = ChecklistItem(text:"Doflamingo")
let item2 = ChecklistItem(text:"Mihawk")
let item3 = ChecklistItem(text:"Pedro",checked:true)
let item4 = ChecklistItem(text:"Marco",checked:true)
let item5 = ChecklistItem(text:"Kaku",checked:true)

table.append(item0)
table.append(item1)
table.append(item2)
table.append(item3)
table.append(item4)
table.append(item5)


do{
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let data = try encoder.encode(table)
    try data.write(to: dataFileUrl!)

    print(String(data: data, encoding: .utf8)!)
    
    
    let jsonData = try Data(contentsOf: dataFileUrl!, options: .alwaysMapped)
    let decoder = JSONDecoder()
    let product = try decoder.decode([ChecklistItem].self, from: jsonData)
    
    for character in product {
        print(character.text)
    }

}catch{
    print(error)
}


