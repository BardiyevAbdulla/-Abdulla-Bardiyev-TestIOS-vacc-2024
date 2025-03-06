//
//  TodoEntity+.swift
//  Todos
//
//  Created by admin on 3/6/25.
//

import Foundation

extension TodoEntity {
    var convertedModel: TodoModel {
        return .init(userId: userId, id: id, title: title, completed: isCompleted, name: name)
    }
}
