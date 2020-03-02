//
//  DataProvider.swift
//  NewsFeed
//
//  Created by sysadmin on 23/02/20.
//  Copyright © 2020 Ramkrishna Sharma. All rights reserved.
//

import Foundation
import CoreData

class DataProvider {
    
    enum CoreDataError: Error {
        case unknown
    }
    
    func syncEmplList(records: [EmployeeData], taskContext: NSManagedObjectContext, completionHandler: ((Result<Bool, Error>) -> Void)) {
        
        taskContext.performAndWait {
            
            // Create new records.
            for item in records {
                
                guard let employee = NSEntityDescription.insertNewObject(forEntityName: Entity.employee, into: taskContext) as? Employee else {
                    print("Error: Failed to create a new object!")
                    return
                }
                
                employee.update(with: item)
            }
            
            // Save all the changes just made and reset the taskContext to free the cache.
            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                } catch {
                    print("Error: \(error)\nCould not save Core Data context.")
                }
                // Reset the context to clean up the cache and low the memory footprint.
                taskContext.reset()
            }
            
            completionHandler(.success(true))
        }

        completionHandler(.failure(CoreDataError.unknown))
    }
    
    func fetch() -> Result<[Employee], Error> {
            
        let fetchRequest = Employee.request
        
        do {
            let records = try Utility.appDelegate().persistentContainer.viewContext.fetch(fetchRequest)
            return .success(records)
        } catch (let error) {
            return .failure(error)
        }
    }
    
    func deleteAllRecords(completionHandler: (Result<Bool, Error>) -> ()) {
        
        let context = Utility.appDelegate().persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.employee)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            completionHandler(.success(true))
        } catch {            
            return completionHandler(.failure(error))
        }
    }
}
