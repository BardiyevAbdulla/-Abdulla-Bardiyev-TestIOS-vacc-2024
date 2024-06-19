//
//  ProfileViewLink.swift
//  ShoppingApp
//
//  Created by admin on 6/19/24.
//

import Foundation

enum ProfileViewLink: Hashable, Identifiable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: String {
        String(describing: self)
    }
    case link
}
