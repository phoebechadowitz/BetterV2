//
//  LoginViewModel.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 7/31/24.
//

import Foundation
class LoginViewModel: Observable {
    var email: String = ""
    var password: String = ""
    func login () {
        Webservice().login(email: email, password: password) { result in
            switch result {
                case .success(let token):
                    print(token)
                case . failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
