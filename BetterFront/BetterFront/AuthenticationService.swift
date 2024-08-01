//
//  LoginViewModel.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 7/31/24.
//

import Foundation
@Observable
class AuthenticationService {
    var identityService: IdentityService
    var email: String = ""
    var password: String = ""
    
    init(identityService: IdentityService) {
        self.identityService = identityService
    }
    func login () {
        Webservice().login(email: email, password: password) { result in
            switch result {
                case .success(let token):
                    print(self.identityService.authenticated)
                    self.identityService.setIdentification(identityToken: token, identityEmail: self.email)
                case . failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
