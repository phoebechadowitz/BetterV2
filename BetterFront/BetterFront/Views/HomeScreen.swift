//
//  HomeScreen.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 8/6/24.
//

import SwiftUI

struct HomeScreen: View {
    private var identityService = IdentityService.shared
    var body: some View {
        Button("Logout") {
            identityService.removeIdentificationFromKeychain()
        }
    }
}

#Preview {
    HomeScreen()
}
