//
//  Caller.swift
//  ChineStore
//
//  Created by admin on 2/9/25.
//

import Foundation
import Combine
import Alamofire

protocol WebRepository {
    
}
struct ErrorMsg: Codable, Error {
    var message: String?
    let status: String?
}

extension WebRepository {
    func callbyAF<T: Codable>(route: (any RouterDataSource), type: T.Type = T.self, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, AFError> {
        return AF.request(route)
            .validate(statusCode:  200 ..< 300)
            .publishDecodable(type: T.self, decoder: decoder)
            .tryMap { dataResponse in
                if let error = dataResponse.error {
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
    
    func callbyAFWithoutValidate<Value: Decodable>(router: URLRequestConvertible) -> AnyPublisher<Value, AFError> {
        AF.request(router)
            //.validate(statusCode:  200 ..< 300)
            .publishDecodable(type: Value.self, decoder: JSONDecoder())
            .tryMap { dataResponse in
                guard let code = dataResponse.response?.statusCode else {
                    throw AFError.sessionTaskFailed(error: ErrorMsg(message: "Network is not working", status: nil))
                }
               
              //  guard code == statusCode else { throw AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: code)) }
                
                if let value = dataResponse.value {
                    return value
                }
                
                guard let data = dataResponse.data else { throw AFError.responseValidationFailed(reason: .dataFileNil) }
                
                do { let value = try JSONDecoder().decode(Value.self, from: data)
                    return value
                }
                catch { throw AFError.responseSerializationFailed(reason: .decodingFailed(error: ErrorMsg(message: "Error to Decode Model check your Decode", status: nil)))}
                
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
