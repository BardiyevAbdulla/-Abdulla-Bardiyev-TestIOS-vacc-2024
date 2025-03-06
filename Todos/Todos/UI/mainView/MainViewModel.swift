//
//  MainViewModel.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation
import Combine
import CoreData

class MainViewModel: ObservableObject {
    enum Router: Equatable {
        case detail(TodoModel)
    }
    
    var navigationPasser = PassthroughSubject<Router, Never>()
   
    var cancellables = Set<AnyCancellable>()
    
    let pageSize = 20
    @Published var pagination: Pagination<TodoModel>
    @Published var items: [TodoModel]?
    init() {
        pagination = Pagination(size: pageSize, router: .init(page: 0, pageSize: pageSize), type: TodoEntity.self)
        
       
        
        pagination.$items
            .receive(on: DispatchQueue.main)
            .assign(to: &$items)
    }
    
    
    
    
    func gotoDetail(_ model: TodoModel) {
        navigationPasser.send(.detail(model))
    }
}
