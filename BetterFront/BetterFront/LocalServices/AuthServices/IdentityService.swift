//
//  IdentityService.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 8/1/24.
//

import Foundation
@Observable
class IdentityService {
    static let shared = IdentityService()
    var email: String = ""
    var token: String = ""
    var authenticated: Bool = false
    
    public func setIdentification(identityToken: String, identityEmail: String) {
        email = identityEmail
        token = identityToken
        authenticated = true
        print(email + token)
        storeIdentificationInKeychain()
    }
    
    func storeIdentificationInKeychain() {
        do {
            try KeychainService.storeToken(token: token, forKey: "jwToken")
            print("Token stored successfully in Keychain.")
        } catch KeychainService.KeychainError.duplicateItem {
            print("Duplicate item error: The token already exists in Keychain.")
        } catch KeychainService.KeychainError.unknown(let status) {
            print("Unknown error: \(status)")
        } catch {
            print("Unexpected error: \(error)")
        }
        
        do {
            try KeychainService.storeToken(token: email, forKey: "email")
            print("Email stored successfully in Keychain.")
        } catch KeychainService.KeychainError.duplicateItem {
            print("Duplicate item error: the email already exists in Keychain.")
        } catch KeychainService.KeychainError.unknown(let status) {
            print("Unknown error: \(status)")
        } catch {
            print("Unexpected error: \(error)")
        }

    }
    
    func loadIdentificationFromKeychain() {
        token = KeychainService.getToken(forKey: "jwToken") ?? ""
        email = KeychainService.getToken(forKey: "email") ?? ""
        if token != ""  && email != "" {
            authenticated = true
        }
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
        
        do {
            try KeychainService.deleteToken(forKey: "email")
            print("Email removed from Keychain.")
        } catch KeychainService.KeychainError.itemNotFound {
            print("Email not found in Keychain")
        } catch KeychainService.KeychainError.unknown(let status) {
            print("Unknown error: \(status)")
        } catch {
            print("Unexpected error: \(error)")
        }

        
    }

}
