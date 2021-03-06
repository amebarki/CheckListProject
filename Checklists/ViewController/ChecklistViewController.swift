//
//  ViewController.swift
//  Checklists
//
//  Created by iem on 01/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

// MARK: - ChecklistViewController
class ChecklistViewController: UITableViewController{

    
    
    var table = [ChecklistItem]()
    var list: Checklist!
   /* var documentDirectory: URL {
        let fm = FileManager.default
        return try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    var dataFileUrl : URL {
        return documentDirectory.appendingPathComponent("checklist").appendingPathExtension("json")
    }*/
    
    override func viewDidLoad() {
        
        
        self.title = list.text
        
        
       /* print(documentDirectory.absoluteString)
        
        print(dataFileUrl.absoluteString)
        print(dataFileUrl.path)
        *//*if(FileManager.default.fileExists(atPath: dataFileUrl.path))
        {
            loadChecklistItems()
        }*/
        
      /*  let item0 = ChecklistItem(text:"Katakuri",checked:true)
        let item1 = ChecklistItem(text:"Doflamingo")
        let item2 = ChecklistItem(text:"Mihawk")
        let item3 = ChecklistItem(text:"Pedro",checked:true)
        let item4 = ChecklistItem(text:"Marco",checked:true)
        let item5 = ChecklistItem(text:"Kaku",checked:true)
       */
       /* table.append(item0)
        table.append(item1)
        table.append(item2)
        table.append(item3)
        table.append(item4)
        table.append(item5)*/

    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return list.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        print("cellForRowAt \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureCheckmark(for: cell, withItem: list.items[indexPath.row])
        configureText(for: cell, withItem: list.items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list.items[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        list.items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    @IBAction func addDummyTodo(_ sender: Any) {
        let item = ChecklistItem(text:"One Piece")
        list.items.append(item)
        let indexPath:IndexPath = IndexPath(row:(list.items.count - 1), section:0)
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
    
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem)
    {
        let cellItem = cell as? ChecklistItemCell
        
        cellItem?.labelCheckmark.isHidden = !item.checked
    }
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem)
    {
        let cellItem = cell as? ChecklistItemCell
        //cell.textLabel?.text = item.text
        cellItem?.labelText.text = item.text
    }
}

// MARK: - AddItemViewControllerDelegate
extension ChecklistViewController: ItemDetailViewControllerDelegate{
    
    
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        dismiss(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        list.items.append(item)
        let indexPath:IndexPath = IndexPath(row:(list.items.count - 1), section:0)
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.fade)
       // saveChecklistItems()
        dismiss(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        let index = list.items.index(where: { $0 === item})!
        let indexPath:IndexPath = IndexPath(row:(index), section:0)
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
       // saveChecklistItems()
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,
            identifier == "addItem",
            let navVC = segue.destination as? UINavigationController,
            let destVC = navVC.topViewController as? ItemDetailViewController {
            destVC.delegate = self
        }
        if let identifier = segue.identifier,
            identifier == "editItem",
            let navVC = segue.destination as? UINavigationController,
            let destVC = navVC.topViewController as? ItemDetailViewController
        {
            destVC.delegate = self
            let index = tableView.indexPath(for: sender as! ChecklistItemCell)!
            destVC.itemtoEdit = list.items[index.row]
        }
        
    }
    
   
    
    
}

