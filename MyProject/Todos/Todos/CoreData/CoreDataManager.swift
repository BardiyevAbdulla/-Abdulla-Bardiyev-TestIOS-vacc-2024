//
//  CoreDataManager.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    var todoList: [TodoEntity] {
        var list: [TodoEntity] = []
        do {
            list = try container.viewContext.fetch(TodoEntity.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        
        return list
    }
    
    var DetailList: [UserEntity] {
        var list: [UserEntity] = []
        do {
            list = try container.viewContext.fetch(UserEntity.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        
        return list
    }
    
    init() {
        self.container = NSPersistentContainer(name: "TodoEntity")
        container.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError("Unresolved error \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        context = container.viewContext
        
       
    }
    
    
    func saveTodo(id: Int64, userId: Int64,title: String, name: String?) {
            //let context = context
            let todo = TodoEntity(context: context)
            todo.id = id
            todo.userId = userId
            todo.title = title
            todo.name = name
            
            do {
                try context.save()
                print("Saved successfully")
            } catch {
                print("Failed to save: \(error.localizedDescription)")
            }
        }
    
    
    
    func deleteAll(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) {
        //let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TodoEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
            let objectIDs = result?.result as? [NSManagedObjectID] ?? []
            
            // Merge changes to the main context
            let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: objectIDs]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
            
            print("All todos deleted successfully")
        } catch {
            print("Failed to delete all: \(error.localizedDescription)")
        }
    }
   
    func deleteTodo(id: Int64) {
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            if let todo = try context.fetch(fetchRequest).first {
                context.delete(todo)
                try context.save()
                print("Deleted successfully")
            }
        } catch {
            print("Failed to delete: \(error.localizedDescription)")
        }
    }
}
