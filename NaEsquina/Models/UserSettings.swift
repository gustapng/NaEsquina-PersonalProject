//
//  Untitled.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 04/11/24.
//

import Foundation
import CoreData
import UIKit

@objc(UserSettings)
class UserSettings: NSManagedObject {
    @NSManaged var userLogged: Bool
    @NSManaged var loggedDate: Date
    
    convenience init(userLogged: Bool, loggedDate: Date) {
        let context = UIApplication.shared.delegate as! AppDelegate
        self.init(context: context.persistentContainer.viewContext)
        self.userLogged = userLogged
        self.loggedDate = loggedDate
    }
}

extension UserSettings {
    
    // MARK: - Core Data - DAO
    
    func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
