//
//  Array+.swift
//  Todos
//
//  Created by admin on 3/6/25.
//

import Foundation

extension Array where Element == TodoEntity {
    var convertedModels: [TodoModel] {
        return map({$0.convertedModel})
    }
}

extension Array where Element == UserEntity {
    var convertedModels: [UserModel] {
        return map({$0.convertedModel})
    }
}
