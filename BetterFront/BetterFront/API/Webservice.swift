//
//  Webservice.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 8/6/24.
//

import Foundation

enum BetCreationError: Error {
    case unauthorized
    case noBetsFound
    case custom(errorMessage: String)
}

struct BetCreationBody: Codable {
    let title: String
    let description: String
    let stakes: Int
}
class Webservice {
    private var identityService = IdentityService.shared
    
    func createBet(title: String, description: String, stakes: Int, completion: @escaping (Result<String, BetCreationError>) -> Void) {
        
    }
    
}
