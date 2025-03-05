//
//  TodoModel.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation
protocol CellDataSourse {
    var name: String? { get set }
    var title: String? { get set }
}

struct TodoModel: BaseDataSource, CellDataSourse {
    var userId: Int64?
    var id: Int64?
    var title: String?
    var completed: Bool?
    var name: String? = nil
}



   
