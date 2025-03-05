//
//  AuthRepository.swift
//  ChineStore
//
//  Created by admin on 2/9/25.
//

import Foundation
import Combine
import Alamofire



protocol AuthRepositoryTemple: WebRepository {
    
}

struct AuthRepository: AuthRepositoryTemple {
    
    func sendNumber(_ number: String) -> AnyPublisher<String, AppError> {
        return self.callbyAF(route: API.aa)
            .mapError { aferror in
                return AppError.aa
            }
            .eraseToAnyPublisher()
    }
}

extension AuthRepository {
    enum API {
        case aa
    }
}

extension AuthRepository.API: RouterDataSource {
    var path: String {
        switch self {
        case .aa:
            return ""
        }
    }
}
