//
//  BetterFrontApp.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 7/14/24.
//

import SwiftUI

@main
struct BetterFrontApp: App {
    @State var identityService = IdentityService()
    init() {
        self.identityService.loadIdentificationFromKeychain()
    }
    var body: some Scene {
        WindowGroup {
            LoginScreen(identityService: self.identityService)
        }
    }
}
