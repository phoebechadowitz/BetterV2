//
//  LoginScreen.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 7/14/24.
//

import SwiftUI

struct LoginScreen: View {
    @State private var loginVM = LoginViewModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Emial", text: $loginVM.email)
                SecureField("Password", text: $loginVM.password)
                Button("Login") {
                    loginVM.login()
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
    LoginScreen()
}
