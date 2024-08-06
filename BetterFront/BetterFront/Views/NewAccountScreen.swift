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
        ZStack {
            VStack {
                Color.mint // Change this to your desired color
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 250) // Adjust the height as needed
                    .overlay(
                        VStack {
                            Spacer()
                            Text("Welcome.")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    )
                Spacer()
            }
            
            
            VStack {
                Spacer()
                if !userCS.errorMessages.isEmpty {
                    VStack(alignment: .leading) {
                        Text(userCS.errorMessages).foregroundColor(.red)
                    }
                    .padding()
                }
                TextField("Email", text: $userCS.email)
                    .textFieldStyle(.roundedBorder)
                SecureField("Password", text: $userCS.password)
                    .textFieldStyle(.roundedBorder)
                SecureField("Re-enter Password", text: $userCS.passwordConfirmation)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    userCS.createUser()
                }) {
                    Text("Create Account")
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(Color.white)
                        .background(Color.mint)
                        .cornerRadius(10)
                }
                .padding()
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    NewAccountScreen()
}
