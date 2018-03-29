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
        
        if(FileManager.default.fileExists(atPath: DataModel.instance.dataFileUrl.path))
        {
          lists = DataModel.instance.loadChecklist()
        }
      /*  let itemA = ChecklistItem(text:"katakuri")
        let itemB = ChecklistItem(text:"Doflamingo")
        let itemC = ChecklistItem(text:"Mihawk")
        table.append(itemA)
        table.append(itemB)
        table.append(itemC)
        let item1 = Checklist(text:"One Piece",paramItems : table)
        table.removeAll()
        for index in 1...5 {
            table.append(ChecklistItem(text:"Final Fantasy  \(index)"))
        }
        let item2 = Checklist(text:"Final Fantasy",paramItems: table)
        
        table.removeAll()
        for index in 1...5 {
            table.append(ChecklistItem(text:"Saga  \(index)"))
        }
        let item3 = Checklist(text:"Elements")
        lists.append(item1)
        lists.append(item2)
        lists.append(item3)*/
     
        
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

extension AllListViewController: ListDetailViewControllerDelegate{
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingList list: Checklist) {
        lists.append(list)
        let indexPath:IndexPath = IndexPath(row:(lists.count - 1), section:0)
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        //saveChecklist()
        dismiss(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingList list: Checklist) {
        let index = lists.index(where: { $0 === list})!
        let indexPath:IndexPath = IndexPath(row:(index), section:0)
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        //saveChecklist()
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,
            identifier == "showList",
            let destVC = segue.destination as? ChecklistViewController{
            let index = tableView.indexPath(for: sender as! UITableViewCell)!
            destVC.list = lists[index.row]
        }
        if let identifier = segue.identifier,
            identifier == "addList",
            let navVC = segue.destination as? UINavigationController,
            let destVC = navVC.topViewController as? ListDetailViewController
        {
            destVC.delegate = self
        }
        if let identifier = segue.identifier,
            identifier == "editList",
            let navVC = segue.destination as? UINavigationController,
            let destVC = navVC.topViewController as? ListDetailViewController
        {
            destVC.delegate = self
            let index = tableView.indexPath(for: sender as! UITableViewCell)!
            destVC.listToEdit = lists[index.row]
        }
}

}
