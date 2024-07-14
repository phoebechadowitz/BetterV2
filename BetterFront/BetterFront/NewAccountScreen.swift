//
//  NewAccountScreen.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 7/14/24.
//

import SwiftUI


struct NewAccountScreen: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var passwordReEntry: String = ""
    var body: some View {
        VStack {
            TextFieldWithLabel(label: "Email", text: $username)
            TextFieldWithLabel(label: "Password", text: $password)
            TextFieldWithLabel(label: "Re-type your password", text: $passwordReEntry)
            Button("Create your Account") {
                // Handle login action
            }
        }
        .padding()
    }
}

#Preview {
    NewAccountScreen()
}
