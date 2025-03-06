//
//  CompanyEntity.swift
//  Todos
//
//  Created by admin on 3/6/25.
//

import Foundation
extension CompanyEntity {
    var convertedModel: UserModel.CompanyModel {
        return .init(name: name, catchPhrase: catchPhrase, bs: bs)
    }
}
