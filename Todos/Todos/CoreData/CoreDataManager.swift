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
    
    func fetchData<T: NSManagedObject>(_ id: Int64, type: T.Type) -> T? {
        let fetchRequest = T.fetchRequest() as! NSFetchRequest<T> // Cast to NSFetchRequest<T>
        fetchRequest.predicate = NSPredicate(format: "id == %d", id) // Filter by ID
        fetchRequest.fetchLimit = 1 // Limit to 1 result

        do {
            return try CoreDataManager.shared.context.fetch(fetchRequest).first
        } catch {
            print("Fetch error: \(error)")
            return nil
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
    
    func fetchData<T: BaseDataSource>(_ model: RequestModel, request: NSManagedObject.Type) -> PageableItems<T>? {
        var value = PageableItems<T>()
        
        //let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        let fetchRequest = request.fetchRequest()
        fetchRequest.fetchLimit = model.pageSize
        fetchRequest.fetchOffset = model.page * model.pageSize
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)] // Adjust sorting if needed
       
        
        if let searchTitle = model.keyword, !searchTitle.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@ OR name CONTAINS[cd] %@", searchTitle, searchTitle)
        }
        do {let content = try context.fetch(fetchRequest)
            if let content = content as? [TodoEntity], let converted = content.convertedModels as? [T] {
                value.content = converted
            }
            
            if let content = content as? [UserEntity], let converted = content.convertedModels as? [T] {
                value.content = converted
            }
            
            value.totalPages = maxPage(pageSize: model.pageSize, type: request)
            value.last = (model.page + 1) >= value.totalPages ?? 0
            value.empty = content.count == 0
            return value
        }
        catch {
            print("error: \(error.localizedDescription)")
        }
        return nil
            if let  content = try? context.fetch(fetchRequest) {
                
                if let content = content as? [TodoEntity], let converted = content.convertedModels as? [T] {
                    value.content = converted
                }
                
                if let content = content as? [UserEntity], let converted = content.convertedModels as? [T] {
                    value.content = converted
                }
                
                value.totalPages = maxPage(pageSize: model.pageSize, type: request)
                value.last = (model.page + 1) >= value.totalPages ?? 0
                value.empty = content.count == 0
                
            } else {
                return nil
            }
            
            return value
    }
    
    func fetchUsers(page: Int, pageSize: Int, searchTitle: String? = nil) -> [TodoEntity] {
        let fetchRequest: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        
        fetchRequest.fetchLimit = pageSize
        fetchRequest.fetchOffset = (page - 1) * pageSize
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)] // Adjust sorting if needed
        
        if let searchTitle, !searchTitle.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@ OR name CONTAINS[cd] %@", searchTitle, searchTitle)

                              }
       
        do {
            return try CoreDataManager.shared.context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch paginated data: \(error.localizedDescription)")
            return []
        }
    }
    
    func max(_ searchString: String? = nil, type: NSManagedObject.Type) -> Int? {
        let fetchRequest = type.fetchRequest()
        if let searchString, searchString.count > 0 {
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@ OR name CONTAINS[cd] %@", searchString, searchString)
        }
        
        guard let totalCount = try? context.count(for: fetchRequest) else { return nil }
       
        return totalCount
        
        
    }
    
    func maxPage(pageSize: Int, type: NSManagedObject.Type) -> Int {
        guard let max = max(type: type) else { return 1 }
        let page = (max + pageSize - 1) / pageSize
        return page
    }
}
