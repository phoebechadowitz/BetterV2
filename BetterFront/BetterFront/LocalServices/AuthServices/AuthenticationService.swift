//
//  LoginViewModel.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 7/31/24.
//

import Foundation
@Observable
class AuthenticationService {
    private var identityService = IdentityService.shared
    var email: String = ""
    var password: String = ""
    var errorMessages: String = ""
    
    init(identityService: IdentityService) {
        self.identityService = identityService
    }
    func login () {
        AuthAPI().login(email: email, password: password) { result in
            switch result {
            case .success(let returnArray):
                print(self.identityService.authenticated)
                self.identityService.setIdentification(identityToken: returnArray[1], identityEmail: returnArray[0])
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

