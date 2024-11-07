//
//  CoreDataManager.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 06/11/24.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var context: NSManagedObjectContext = {
        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return AppDelegate.persistentContainer.viewContext
    }()
    
    private init() {}
}
