//
//  AllListViewController.swift
//  Checklists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    var table = [ChecklistItem]()
    
    var dataModelInstance = DataModel.instance
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(FileManager.default.fileExists(atPath: dataModelInstance.dataFileUrl.path))
        {
          dataModelInstance.loadChecklist()
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataModelInstance.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath)
        cell.textLabel?.text = dataModelInstance.lists[indexPath.row].text
        cell.detailTextLabel?.text = determineStateChecklist(index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataModelInstance.lists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    func determineStateChecklist(index: Int) -> String
    {
        if dataModelInstance.lists[index].items.count == 0
        {
            return "No Item"
        }
        else
        {
            switch dataModelInstance.lists[index].uncheckedItemsCount {
            case 0:
                return "All Done !"
            default:
                return "Number of unchecked items : \(dataModelInstance.lists[index].uncheckedItemsCount)"
            }
        }
    }
   
    
}

extension AllListViewController: ListDetailViewControllerDelegate{
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        tableView.reloadData()
        dismiss(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingList list: Checklist) {
        dataModelInstance.lists.append(list)
        let indexPath:IndexPath = IndexPath(row:(dataModelInstance.lists.count - 1), section:0)
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        //DataModel.instance.saveChecklist()
        dismiss(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingList list: Checklist) {
        let index = dataModelInstance.lists.index(where: { $0 === list})!
        let indexPath:IndexPath = IndexPath(row:(index), section:0)
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        //DataModel.instance.saveChecklist()
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,
            identifier == "showList",
            let destVC = segue.destination as? ChecklistViewController{
            let index = tableView.indexPath(for: sender as! UITableViewCell)!
            destVC.list = dataModelInstance.lists[index.row]
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
            destVC.listToEdit = dataModelInstance.lists[index.row]
        }
}

}
