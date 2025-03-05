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
    @Published var pagination: TodoListController
    var cancellables = Set<AnyCancellable>()
    init() {
        pagination = TodoListController()
       
    }
    
    
    func fetchData() {
        pagination.update()
    }
    
    func gotoDetail(_ model: TodoModel) {
        navigationPasser.send(.detail(model))
    }
}
