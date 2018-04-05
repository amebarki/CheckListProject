//
//  IconAsset.swift
//  Checklists
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//
import UIKit
import Foundation

enum IconAsset : String,Codable
{
    case Appointments
    case Birthdays
    case Chores
    case Drinks
    case Folder
    case Groceries
    case Inbox
    case NoIcon = "No Icon"
    case Photos
    case Trips
    
    static let arrayIconAssets = [Appointments,Birthdays,Chores,Drinks,Folder,Groceries,Inbox,NoIcon,Photos,Trips]
    
    var image : UIImage {
        return UIImage(named: self.rawValue)!
    }
}


enum StandardString : String,Codable
{
    case firstLaunch = "firstLaunch"
    
}
