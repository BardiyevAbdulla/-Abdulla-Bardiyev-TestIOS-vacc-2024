//
//  UserEntity+.swift
//  Todos
//
//  Created by admin on 3/6/25.
//

import Foundation

extension UserEntity {
    var convertedModel: UserModel {
        var model = UserModel(id: id, name: name, username: username, email: email, phone: phone, website: website, address: address?.convertedModel, company: company?.convertedModel)
        
        return model
    }
}




