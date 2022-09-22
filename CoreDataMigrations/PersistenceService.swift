//
//  PersistenceService.swift
//  CoreDataMigrations
//
//  Created by Karina gurachevskaya on 22.09.22.
//

import CoreData
import SwiftUI

final class PersistenseService: ObservableObject {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Groceries")
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static let shared = PersistenseService()
    
    private init() {
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unable to load persistent stores: \(error)")
            }
        }
    }
    
    func addItem(name: String) throws {
        let newItem = GroceryItem(context: context)
        newItem.name = name
        do {
            try save()
        } catch let error {
            throw error
        }
    }
    
    func deleteItem(_ item: GroceryItem) throws {
        context.delete(item)
        do {
            try save()
        } catch let error {
            throw error
        }
    }
    
    private func save() throws {
        do {
            try context.save()
        } catch let error {
            context.rollback()
            throw error
        }
    }
}
