//
//  KeychainService.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 8/1/24.
//

import Foundation
import Security

class KeychainService {
    
    enum KeychainError: Error {
        case duplicateItem
        case itemNotFound
        case unknown(OSStatus)
    }
    
    static func storeToken(token: String, forKey key: String) throws {
        if let data = token.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data,
                kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
            ]

            let status = SecItemAdd(query as CFDictionary, nil)

            guard status != errSecDuplicateItem else {
               throw KeychainError.duplicateItem
            }

            guard status == errSecSuccess else {
               throw KeychainError.unknown(status)
            }
        }
    }
    
    static func getToken(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess, let data = dataTypeRef as? Data {
             return String(data: data, encoding: .utf8)
        }

        return nil
    }
    
    static func deleteToken(forKey key: String) throws {
            // Create a query dictionary to identify the password item to delete from the Keychain
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword, // Specifies the item class as a generic password
                kSecAttrAccount as String: key, // The account name identifying the password data item
            ]
            
            // Attempt to delete the password item from the Keychain
            let status = SecItemDelete(query as CFDictionary)
            
            // Check the result of the Keychain operation and throw appropriate errors if needed
            if status == errSecItemNotFound {
                throw KeychainError.itemNotFound
            } else if status != errSecSuccess {
                throw KeychainError.unknown(status) 
            }
        }

    
}
