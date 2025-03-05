//
//  Pagination.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation
import Combine
import Alamofire

class TodoListController: ObservableObject {
    
    private var current: Int = 0
    
    private var max: Int? = nil
    
    private var size: Int = 20
    
   
    private var error: AFError?
    private var cancellable: AnyCancellable?
    @Published public var items: [TodoModel]?// = []
    private var baseItem: [TodoModel] = []
    var searchTitle: String? = nil
    
    init(size: Int) {
        self.size = size
        
        NotificationCenter.default.addObserver(forName: .dataUploaded, object: nil, queue: .main) {[weak self] _ in
            DispatchQueue.main.async {
                
                self?.fetchData()
            }
           
        }
       
    }
    
    
    
    func update() {
       
        
        guard current < (max ?? 0), searchTitle?.isEmpty ?? true else { return }
        let count = size * current
        current += 1
        let tempSize = current == max ? baseItem.count / size : size
        // handle
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {[weak self] _ in
            guard let self else { return }
            
            self.items?.append(contentsOf: self.baseItem[count...count+tempSize])
        }
        
        
    }
    
    //MARK: FETCH DATA
   
    func fetchData(_ nonDeletingCurrent: Bool = false) {
        baseItem = []
        
        
        for item in CoreDataManager.shared.todoList {
            let name = CoreDataManager.shared.DetailList.first(where: {$0.id == item.userId})?.name
            let tempItem = TodoModel(userId: item.userId, id: item.id, title: item.title, completed: item.isCompleted, name: name)
            
            baseItem.append(tempItem)
        }
        self.current = 1
        
        self.max = Int(ceil(Double(baseItem.count) / Double(size)))//(baseItem.count / size).a
        items = Array(baseItem.prefix(size))
        return
       

    }
    
    func search(_ title: String? = nil) {
        
        searchTitle = title
        guard let title, title.count > 0  else {
            self.items = Array(baseItem.prefix( size * current))
            return
        }
        let searchedByTitle = baseItem.filter({$0.title?.lowercased().contains(title.lowercased()) ?? false})
        
        let searchedByName = baseItem.filter({$0.name?.lowercased().contains(title.lowercased()) ?? false})
        
        self.items =  Array(Set(searchedByTitle + searchedByName)) // [1(searchedByTitle + searchedByName).
    }
    
    deinit {
    //    cancellable?.cancel()
    }
}
