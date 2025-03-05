//
//  VerifyRepository.swift
//  ChineStore
//
//  Created by admin on 2/9/25.
//

import Foundation
import Combine

protocol VerifyRepositoryTemple: WebRepository {
    
}

struct VerifyRepository: VerifyRepositoryTemple {
    
    func sendNumber(_ number: String) -> AnyPublisher<String, AppError> {
        return self.callbyAF(route: API.aa)
            .mapError { aferror in
                return AppError.aa
            }
            .eraseToAnyPublisher()
    }
}

extension VerifyRepository {
    enum API {
        case aa
    }
}

extension VerifyRepository.API: RouterDataSource {
    var path: String {
        switch self {
        case .aa:
            return ""
        }
    }
}
