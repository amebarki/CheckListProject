//
//  AllListViewController.swift
//  Checklists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    var lists = [Checklist]()
    var table = [ChecklistItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemA = ChecklistItem(text:"katakuri")
        let itemB = ChecklistItem(text:"Doflamingo")
        let itemC = ChecklistItem(text:"Mihawk")
        table.append(itemA)
        table.append(itemB)
        table.append(itemC)
        
        let item1 = Checklist(text:"One Piece",paramItems : table)
        let item2 = Checklist(text:"Final Fantasy")
        let item3 = Checklist(text:"Elements")
        lists.append(item1)
        lists.append(item2)
        lists.append(item3)
     
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row].text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
}
