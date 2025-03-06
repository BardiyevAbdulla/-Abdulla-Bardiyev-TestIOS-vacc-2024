//
//  File.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation

protocol BaseDataSource: Codable, Identifiable, Hashable {
   // associatedtype ID: Hashable
    var id: ID { get set }
//    var verified: Bool? { get set }
   
}
