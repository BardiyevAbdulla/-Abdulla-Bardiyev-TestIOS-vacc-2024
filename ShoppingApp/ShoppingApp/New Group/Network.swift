//
//  Network.swift
//  ShoppingApp
//
//  Created by admin on 6/19/24.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    
    // Replace with your GraphQL endpoint
    private(set) lazy var apollo: ApolloClient = {
        let url = URL(string: "https://testzad.foodexcapital.com/gql")!
        return ApolloClient(url: url)
    }()
}
