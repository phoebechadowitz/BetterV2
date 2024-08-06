//
//  PasswordRecoveryService.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 8/2/24.
//

import Foundation
@Observable
class PasswordRecoveryService {
    var email: String = ""
    var message: String = ""
    
    func sendRecoveryEmail() {
        AuthAPI().sendRecoveryEmail(email: self.email) { result in
            switch result {
            case .success(let message):
                self.message = message
            case .failure(let error):
                switch error {
                case .custom(let errorMessage):
                    self.message = errorMessage
                default:
                    self.message = "An unknown error occurred"
                }
            }
        }
    }
}

