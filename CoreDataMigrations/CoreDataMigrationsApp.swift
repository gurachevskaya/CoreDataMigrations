//
//  CoreDataMigrationsApp.swift
//  CoreDataMigrations
//
//  Created by Karina gurachevskaya on 21.09.22.
//

import SwiftUI

@main
struct CoreDataMigrationsApp: App {
    
    @StateObject var persistenceService = PersistenseService.shared

    var body: some Scene {
        WindowGroup {
            GroceriesView()
                .environment(\.managedObjectContext, persistenceService.context)
        }
    }
}
