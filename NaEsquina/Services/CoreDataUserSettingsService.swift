//
//  CoreDataUserSettingsService.swift
//  NaEsquina
//
//  Created by Gustavo Ferreira dos Santos on 24/11/24.
//

import CoreData

final class CoreDataUserSettingsService {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = context
    }

    func getUserSettings() -> UserSettings? {
        let fetchRequest: NSFetchRequest<UserSettings> = UserSettings.fetchRequest()
        return try? context.fetch(fetchRequest).last
    }

    func updateFaceIDSettings(enabled: Bool) {
        let userSettings = getUserSettings() ?? UserSettings(context: context)
        userSettings.isFaceIDEnabled = enabled
        userSettings.loggedDate = Date()
        try? context.save()
    }
}
