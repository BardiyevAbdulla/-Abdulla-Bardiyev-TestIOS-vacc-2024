//
//  APICaller.swift
//  Todos
//
//  Created by admin on 3/3/25.
//

import Foundation
import Combine
import Alamofire

class APICaller {

    static let shared = APICaller()
    
    func fetchTodoList() -> AnyPublisher<[TodoModel]?, AFError> {
        self.callbyAF(route: Router.todoList)
    }
    
    func fetchUsers() -> AnyPublisher<[UserModel]?, AFError> {
        self.callbyAF(route: Router.users)
    }
    
    func fetchUsers(id: Int64) -> AnyPublisher<UserModel?, AFError> {
        self.callbyAF(route: Router.user(id: id))
    }
}

extension APICaller {
    func callbyAF<T: Codable>(route: (any RouterDataSource), type: T.Type = T.self, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, AFError> {
        return AF.request(route)
            .validate(statusCode:  200 ..< 300)
            .publishDecodable(type: T.self, decoder: decoder)
            .tryMap { dataResponse in
                if let error = dataResponse.error {
//                    let title = {
//                        switch error {
//                    case .sessionTaskFailed:
//                        return "Check your internet connection"
//                    default: return "Something went wrong"
//                    }
//                    }
//                    NotificationCenter.default.post(name: .failedUploadData, object: title)
                    throw error
                }
                
                guard let statusCode = dataResponse.response?.statusCode else {
                    throw AFError.responseValidationFailed(reason: .dataFileNil)  }
                
                guard (200 ..< 300).contains(statusCode) else {
                    throw AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: statusCode))
                }
                if let value = dataResponse.value {
                    return value
                }
                
                throw AFError.responseValidationFailed(reason: .dataFileNil)
                //  return dataResponse.result
            }
            .mapError { error in
                if let afError = error as? AFError {
                    return afError
                } else {
                    return AFError.sessionTaskFailed(error: error)
                }
            }
            .eraseToAnyPublisher()
    }
}
