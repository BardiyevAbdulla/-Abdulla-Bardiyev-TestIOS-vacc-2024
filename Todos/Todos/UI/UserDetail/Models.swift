//
//  Models.swift
//  Todos
//
//  Created by admin on 3/5/25.
//

import Foundation

struct SectionData {
let section: String
    let aa: [CellData]
}

struct CellData: CellDataSourse {
    var name: String?
    
    var title: String?
}
