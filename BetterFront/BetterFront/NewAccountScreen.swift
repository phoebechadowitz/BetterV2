//
//  NewAccountScreen.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 7/14/24.
//

import SwiftUI


struct NewAccountScreen: View {
    @State var userCS = UserCreationService()
    @State private var errorMessages: [String] = []

    var body: some View {
        VStack {
            TextField("Email", text: $userCS.email)
            SecureField("Password", text: $userCS.password)
            SecureField("Re-Enter your password", text: $userCS.passwordConfirmation)
            Button("Create your Account") {
                userCS.createUser()
            }
            .padding()
            if !userCS.errorMessages.isEmpty {
                VStack(alignment: .leading) {
                        Text(userCS.errorMessages).foregroundColor(.red)
                }
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    NewAccountScreen()
}
