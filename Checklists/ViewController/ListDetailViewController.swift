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
    
    @IBOutlet weak var textField: UITextField!
    
    
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
            delegate?.listDetailViewController(self, didFinishEditingList: list)
        }
        else
        {
            let text = (textField.text ?? "not work")
            delegate?.listDetailViewController(self, didFinishAddingList: Checklist(text: text))
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
protocol ListDetailViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingList list: Checklist)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingList list: Checklist)
}

