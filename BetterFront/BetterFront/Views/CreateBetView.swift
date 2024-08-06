//
//  CreateBetView.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 8/6/24.
//

import SwiftUI

struct CreateBetView: View {
    @Bindable private var betCreator = BetCreationService()
    var body: some View {
        VStack {
            TextField("Title", text: $betCreator.title)
                .textFieldStyle(.roundedBorder)
            TextField("Description", text: $betCreator.description)
                .textFieldStyle(.roundedBorder)
            TextField("Stakes", text: Binding(
                get: { String(betCreator.stakes) },
                set: { betCreator.stakes = Int($0) ?? 0 }
            ))
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
            Button("Create Bet") {
                
            }
            .fontWeight(.bold)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundStyle(Color.white)
            .background(Color.mint)
            .cornerRadius(10)
        }
        .padding()
    }
}

#Preview {
    CreateBetView()
}
