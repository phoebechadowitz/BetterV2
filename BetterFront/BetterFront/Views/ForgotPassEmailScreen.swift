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
        VStack {
            Text("Please enter the email associated with your account")
            TextField("Email", text: $passRecovery.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Send Recovery Email") {
                passRecovery.sendRecoveryEmail()
                emailSent = true
                remainingTime = 60

            }
            .disabled(passRecovery.email.isEmpty)
            .disabled(emailSent)

            if emailSent {
                Text(passRecovery.message)
                    .padding()
                Text("You may send another recovery email in " + remainingTime.formatted() + " seconds")
            }
        }
        .padding()
        .onReceive(timer) { _ in
                    if emailSent && remainingTime > 0 {
                        remainingTime -= 1
                        if remainingTime == 0 {
                            emailSent = false
                        }
                    }
                }

    }
}

#Preview {
    ForgotPassEmailScreen()
}
