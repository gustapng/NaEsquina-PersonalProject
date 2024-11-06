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
    @NSManaged var isFaceIDEnabled: Bool
    @NSManaged var loggedDate: Date

    convenience init(isFaceIDEnabled: Bool, loggedDate: Date) {
        let context = UIApplication.shared.delegate as! AppDelegate
        self.init(context: context.persistentContainer.viewContext)
        self.isFaceIDEnabled = isFaceIDEnabled
        self.loggedDate = loggedDate
    }
}

extension UserSettings {

    // MARK: - Core Data - DAO

    static func fetchRequest() -> NSFetchRequest<UserSettings> {
        return NSFetchRequest(entityName: "UserSettings")
    }

    func save(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    class func fetchResult(_ fetchedResultController: NSFetchedResultsController<UserSettings>) {
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
}
