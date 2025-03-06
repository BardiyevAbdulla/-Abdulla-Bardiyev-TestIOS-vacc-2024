//
//  UserModel.swift
//  Todos
//
//  Created by admin on 3/5/25.
//

import Foundation

struct UserModel: BaseDataSource {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
    
    var id: Int64?
    var name: String?
    var username: String?
    var email: String?
    var phone: String?
    var website: String?
    var address: AddressModel?
    var company: CompanyModel?
    
    struct AddressModel: Codable {
        var street: String?
        var suite: String?
        var city: String?
        var zipcode: String?
        //var geo: GeoModel?
        
        struct GeoModel: Codable {
            var lat: Double?
            var lng: Double?
        }
    }
    
    struct CompanyModel: Codable {
        var name: String?
        var catchPhrase: String?
        var bs: String?
    }
    
}
