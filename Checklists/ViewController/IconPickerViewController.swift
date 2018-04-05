//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class IconPickerViewController: UITableViewController {

    var delegate: IconPickerViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return IconAsset.arrayIconAssets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconItem", for: indexPath)
        cell.imageView?.image = IconAsset.arrayIconAssets[indexPath.row].image
        cell.textLabel?.text = IconAsset.arrayIconAssets[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.iconPickerViewController(self, didFinishChosingIcon: IconAsset.arrayIconAssets[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}


// MARK: - AddItemViewControllerDelegate
protocol IconPickerViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func iconPickerViewController(_ controller: IconPickerViewController, didFinishChosingIcon icon: IconAsset)
}
