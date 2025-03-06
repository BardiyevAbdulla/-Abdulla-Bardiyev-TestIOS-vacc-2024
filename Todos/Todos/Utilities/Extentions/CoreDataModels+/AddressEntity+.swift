//
//  AddressEntity+.swift
//  Todos
//
//  Created by admin on 3/6/25.
//

import Foundation

extension AdressEntity {
    var convertedModel: UserModel.AddressModel {
        return .init(street: street, suite: suite, city: city, zipcode: zipcode)
    }
}
