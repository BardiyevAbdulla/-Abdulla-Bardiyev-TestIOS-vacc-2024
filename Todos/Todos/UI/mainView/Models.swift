//
//  Models.swift
//  Todos
//
//  Created by admin on 3/6/25.
//

import Foundation
struct PageableItems<T: BaseDataSource> {
    
    var totalPages: Int?
    
    var totalElements: Int?
    
    var last: Bool?
    
    var size: Int?
    
    var number: Int?
    
    var numberOfElements: Int?
    
    var first: Bool?
    
    var empty: Bool?
    
    var content: [T]?
}
