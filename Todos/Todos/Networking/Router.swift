//
//  Router.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation
//https://jsonplaceholder.typicode.com/todos
fileprivate let baseUrl = "https://jsonplaceholder.typicode.com/"
fileprivate let todosList = "\(baseUrl)todos"
fileprivate let userList = "\(baseUrl)users"

enum Router: RouterDataSource {
    case todoList
    case user(id: Int64)
    case users
    var path: String {
        switch self {
        case .todoList:
            return todosList
        case .user(let id): 
            
            return "\(userList)/\(id)"
        case .users:
            return userList
        }
    }
    
    
}
