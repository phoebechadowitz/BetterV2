//
//  IdentityService.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 8/1/24.
//

import Foundation
@Observable
class IdentityService {
    var email: String = ""
    var token: String = ""
    var authenticated: Bool = false
    
    public func setIdentification(identityToken: String, identityEmail: String) {
        email = identityEmail
        token = identityToken
        storeIdentificationInKeychain()
        authenticated = true
    }
    
    func storeIdentificationInKeychain() {
        do {
            try KeychainService.storeToken(token: token)
            print("Token stored successfully in Keychain.")
        } catch KeychainService.KeychainError.duplicateItem {
            print("Duplicate item error: The token already exists in Keychain.")
        } catch KeychainService.KeychainError.unknown(let status) {
            print("Unknown error: \(status)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func loadIdentificationFromKeychain() {
        token = KeychainService.getToken(forKey: "jwToken") ?? ""
    }
    
    func removeIdentificationFromKeychain() {
        email = ""
        token = ""
        authenticated = false
        do {
            try KeychainService.deleteToken(forKey: "jwToken")
            print("Token removed from Keychain.")
        } catch KeychainService.KeychainError.itemNotFound {
            print("Item not found in Keychain")
        } catch KeychainService.KeychainError.unknown(let status) {
            print("Unknown error: \(status)")
        } catch {
            print("Unexpected error: \(error)")
        }
        
    }

}
