//
//  CoreDataManager.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
import CoreData
import os.log
final class CoreDataManager {
    static let shared = CoreDataManager()
   
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MockCommerce")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Core Data yüklenemedi: \(error.localizedDescription)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    
    
    
}

extension CoreDataManager:CoreDataManaging {
    func fetch<T>(_ request: NSFetchRequest<T>) async throws -> [T] where T : NSFetchRequestResult {
        try await withCheckedThrowingContinuation { continuation in
                    context.perform {
                        do {
                            let result = try self.context.fetch(request)
                            continuation.resume(returning: result)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    }
                }
    }
    
    func saveChanges() async throws {
        Logger.storedCart.debug("💾 Saving Core Data context...")
        try await withCheckedThrowingContinuation { continuation in
            context.perform {
                do {
                    if self.context.hasChanges {
                        try self.context.save()
                    }
                    continuation.resume()
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    
    func delete(_ object: NSManagedObject)  {
        context.delete(object)
//        await saveChanges()
    }
    
}
