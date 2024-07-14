//
//  LoginScreen.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 7/14/24.
//

import SwiftUI

struct LoginScreen: View {
    @State var username: String = ""
    @State var password: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextFieldWithLabel(label: "Email", text: $username)
                TextFieldWithLabel(label: "Password", text: $password)
                Button("Login") {
                    // Handle login action
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
