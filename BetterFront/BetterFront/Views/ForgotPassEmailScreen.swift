//
//  ForgotPassEmailSentPage.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 8/2/24.
//

import SwiftUI

struct ForgotPassEmailScreen: View {
    private var identityService = IdentityService.shared
    @Bindable private var passRecovery = PasswordRecoveryService()
    @State private var emailSent = false
    @State private var remainingTime = 0
    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        ZStack {
            VStack {
                Color.mint
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 250) // Adjust the height as needed
                    .overlay(
                        VStack {
                            Spacer()
                            Text("Please enter the email associated with your account.")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            Spacer()
                        })
                Spacer()
            }
            VStack {
                if emailSent {
                    if let message = passRecovery.message {
                                            Text(message)
                                                .foregroundColor(.mint)
                                                .font(.headline)
                                        }
                }
                if let error = passRecovery.error {
                                        Text(error)
                                            .foregroundColor(.red)
                                            .font(.headline)
                                    }
                HStack {
                    Image(systemName: "envelope")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.mint)
                    TextField("Email", text: $passRecovery.email)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.bottom)
                Button("Send Recovery Email") {
                    passRecovery.message = nil
                    passRecovery.error = nil
                    passRecovery.sendRecoveryEmail()
                    emailSent = true
                    remainingTime = 60
                }
                .disabled(passRecovery.email.isEmpty)
                .disabled(emailSent)
                .fontWeight(.bold)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundStyle(Color.white)
                .background(emailSent ? Color.gray.opacity(0.8) : Color.mint)
                .cornerRadius(10)
                
                if emailSent && passRecovery.message != nil {
                    Text("You may send another recovery email in " + remainingTime.formatted() + " seconds")
                        .foregroundStyle(.mint)
                        .font(.callout)
                }
            }
            
            .padding()
            .onReceive(timer) { _ in
                if passRecovery.error != nil {
                    emailSent = false
                }
                if emailSent && remainingTime > 0 {
                    remainingTime -= 1
                    if remainingTime == 0 {
                        emailSent = false
                    }
                }
            }
        }
    }
}

#Preview {
    ForgotPassEmailScreen()
}
