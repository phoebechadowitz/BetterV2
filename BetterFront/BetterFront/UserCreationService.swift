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
    var authService: AuthenticationService = AuthenticationService(identityService: IdentityService.shared)
    

    func createUser() {
        Webservice().createUser(email: email, password: password, passwordConfirmation: passwordConfirmation) { result in
            switch result {
            case .success(let message):
                self.errorMessages = message
                self.authService.email = self.email
                self.authService.password = self.password
                self.authService.login()
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
