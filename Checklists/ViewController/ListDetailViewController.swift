//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    
    var delegate: ListDetailViewControllerDelegate?
    var listToEdit: Checklist?
    var iconChecklist = IconAsset.Folder

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        if let list = listToEdit
        {
            self.title = "Edit List"
            textField.text = list.text
        }else
        {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
    }
    

    
    @IBAction func cancel(_ sender: Any) {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(_ sender: Any) {
        if let list = listToEdit
        {
            list.text = textField.text!
            list.icon = iconChecklist
            delegate?.listDetailViewController(self, didFinishEditingList: list)
        }
        else
        {
            let text = (textField.text ?? "not work")
            delegate?.listDetailViewController(self, didFinishAddingList: Checklist(paramText: text,paramIcon: iconChecklist))
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
        if let list = listToEdit
        {
            imageView.image = list.icon.image
        }
        else
        {
            imageView.image = iconChecklist.image
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let oldString = textField.text {
            let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!,
                                                          with: string)
            if(newString.count == 0)
            {
                navigationItem.rightBarButtonItem?.isEnabled = false
            }else
            {
                navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    }
}

extension ListDetailViewController: IconPickerViewControllerDelegate
{
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true)
    }
    
    func iconPickerViewController(_ controller: IconPickerViewController, didFinishChosingIcon icon: IconAsset) {
        iconChecklist = icon
        imageView.image = iconChecklist.image
        if let list = listToEdit
        {
            list.icon = iconChecklist
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,
            identifier == "showIconPicker",
            let destVC = segue.destination as? IconPickerViewController
        {
            destVC.delegate = self
        }
    }

    
    
}




// MARK: - AddItemViewControllerDelegate
protocol ListDetailViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingList list: Checklist)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingList list: Checklist)
}

