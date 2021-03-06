//
//  AddItemViewController.swift
//  Checklists
//
//  Created by iem on 08/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

// MARK: - AddItemViewController
class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

    var delegate: ItemDetailViewControllerDelegate?
    var itemtoEdit: ChecklistItem?
    
    @IBOutlet weak var textField: UITextField!
   

    override func viewDidLoad() {
        if let item = itemtoEdit
        {
            self.title = "Edit Item"
            textField.text = item.text
        }else
        {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }

    @IBAction func validateText(_ sender: Any) {
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }

    @IBAction func done(_ sender: Any) {
        if let item = itemtoEdit
        {
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
        }
        else
        {
            delegate?.itemDetailViewController(self, didFinishAddingItem: ChecklistItem(text: textField.text ?? "not work"))
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
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
}


// MARK: - AddItemViewControllerDelegate
protocol ItemDetailViewControllerDelegate : class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
}
