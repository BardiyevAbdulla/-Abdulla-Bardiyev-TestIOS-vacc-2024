//
//  BaseModel.swift
//  ChineStore
//
//  Created by admin on 2/6/25.
//

import Foundation

protocol BaseDataSource: Codable, Identifiable, Hashable {
   
    var id: ID { get set }
   
}
