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
            ZStack {
                VStack {
                    Color.mint // Change this to your desired color
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 250) // Adjust the height as needed
                        .overlay(
                            VStack {
                                Spacer()
                                Text("Better.")
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
                    if !authService.errorMessages.isEmpty {
                        VStack(alignment: .leading) {
                            Text(authService.errorMessages).foregroundColor(.red)
                        }
                        .padding()
                    }
                    
                    HStack {
                        Image(systemName: "envelope")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.mint)
                        TextField("Email", text: $authService.email)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack {
                        Image(systemName: "lock.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.mint)

                        SecureField("Password", text: $authService.password)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack {
                        Spacer()
                        NavigationLink(destination: ForgotPassEmailScreen()) {
                            Text("Forgot password?")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.mint)
                        }
                    }
                    Button(action: {
                        authService.login()
                    }) {
                        Text("Login")
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(Color.white)
                            .background(Color.mint)
                            .cornerRadius(10)
                    }
                    Spacer()
                    HStack {
                        Text("Dont have an account?")
                        NavigationLink(destination: NewAccountScreen()) {
                            Text("Sign up!")
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.mint)
                        }
                    }
                }
                .padding()
            }
        }
        .tint(.white)
    }
}

#Preview {
    LoginScreen()
}
