//
//  LoginScreen.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 7/14/24.
//

import SwiftUI

struct LoginScreen: View {
    
    @Bindable private var authService: AuthenticationService
    @State var identityService: IdentityService

    init(identityService: IdentityService) {
        self.identityService = identityService
        self.authService = AuthenticationService(identityService: identityService)
        }


    var body: some View {
        NavigationView {
            VStack {
                TextField("Emial", text: $authService.email)
                SecureField("Password", text: $authService.password)
                Button("Login") {
                    authService.login()
                }
                Button("print keychain") {
                    print(KeychainService.getToken(forKey: "jwToken") ?? "no token found in keychain")
                    print("identity serv:")
                    print(identityService.token)
                }
                Button("Logout") {
                    identityService.removeIdentificationFromKeychain()
                    print("identity serv:")
                }
                NavigationLink(destination: NewAccountScreen()) {
                    Text("Create a new account")
                }
            }
            .padding()
            .navigationBarTitle("Login")
        }
    }
}

#Preview {
    LoginScreen(identityService: IdentityService())
}
