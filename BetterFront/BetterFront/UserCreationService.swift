//
//  UserCreationService.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 8/1/24.
//

import Foundation
@Observable
class UserCreationService {
    var email: String = ""
    var password: String = ""
    var passwordConfirmation: String = ""
    var errorMessages: String = ""
    
    func createUser() {
        Webservice().createUser(email: email, password: password, passwordConfirmation: passwordConfirmation) { result in
            switch result {
            case .success(let message):
                // Handle success (e.g., navigate to another screen)
                self.errorMessages = message
            case .failure(let error):
                switch error {
                    case .custom(let errorMessage):
                        self.errorMessages = errorMessage
                    print(self.errorMessages)
                    default:
                        self.errorMessages = "An unknown error occurred"
                    }
                }
            }
        }
}
