//
//  CoreDataManaging.swift
//  MockCommerce
//
//  Created by Güncel Aldemir on 15.07.2025.
//

import Foundation
import CoreData
protocol CoreDataManaging {
    var context: NSManagedObjectContext { get }
       
    func saveChanges() async throws
       func fetch<T: NSFetchRequestResult>(_ request: NSFetchRequest<T>) async throws -> [T]

       func delete(_ object: NSManagedObject)
}
