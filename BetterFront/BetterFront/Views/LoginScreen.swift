//
//  LoginScreen.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 7/14/24.
//

import SwiftUI

struct LoginScreen: View {
    
    @Bindable private var authService = AuthenticationService(identityService: IdentityService.shared)
    @State private var identityService = IdentityService.shared

    


    var body: some View {
        NavigationView {
            VStack {
                if !authService.errorMessages.isEmpty {
                    VStack(alignment: .leading) {
                        Text(authService.errorMessages).foregroundColor(.red)
                    }
                    .padding()
                }
                
                if !identityService.authenticated {
                    TextField("Email", text: $authService.email)
                    SecureField("Password", text: $authService.password)
                    Button("Login") {
                        authService.login()
                    }
                    NavigationLink(destination: NewAccountScreen()) {
                        Text("Create a new account")
                    }
                    NavigationLink(destination: NewAccountScreen()) {
                        Text("Create a new account")
                    }

                }
                else {
                    Button("Logout") {
                        identityService.removeIdentificationFromKeychain()
                        print("identity serv: " + identityService.token)
                    }
                    
                    Text(KeychainService.getToken(forKey: "jwToken") ?? "no token found in keychain")
                }
                Button("print keychain") {
                    
                    print("identity serv:")
                    print(identityService.token)
                }
                
                
            }
            .padding()
            .navigationBarTitle(identityService.authenticated ? "Welcome \(identityService.email)" : "Login"
                                
)
        }
    }
}

#Preview {
    LoginScreen()
}
