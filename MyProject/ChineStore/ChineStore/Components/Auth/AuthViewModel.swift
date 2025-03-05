//
//  AuthViewModel.swift
//  ChineStore
//
//  Created by admin on 2/6/25.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var number: String
    private var repo = AuthRepository()
    
    init(number: String) {
        self.number = number
    }
    
    func sendNumber() {
        repo.sendNumber(self.number)
            .sink(receiveCompletion: handleError) { _ in
                
            }
            

    }
    
    func handleError(_ error: Subscribers.Completion<AppError>) {
        
    }
}
