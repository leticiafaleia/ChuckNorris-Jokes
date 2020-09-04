//
//  ViewControllerExtension.swift
//  Fatos CN
//
//  Created by Letícia Santos on 04/09/20.
//  Copyright © 2020 Letícia Santos. All rights reserved.
//

import UIKit
import CoreData


extension UIViewController {
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
