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
    var message: String?
    var error: String?
    
    func sendRecoveryEmail() {
        AuthAPI().sendRecoveryEmail(email: self.email) { result in
            switch result {
            case .success(let message):
                self.message = message
            case .failure(let error):
                switch error {
                case .custom(let errorMessage):
                    self.error = errorMessage
                default:
                    self.error = "An unknown error occurred"
                }
            }
        }
    }
}

