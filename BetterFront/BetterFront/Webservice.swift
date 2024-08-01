//
//  Webservice.swift
//  BetterFront
//
//  Created by Phoebe Chadowitz on 7/31/24.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum UserCreationError: Error {
    case userAlreadyExists
    case custom(errorMessage: String)
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}

struct LoginResponseBody: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}


struct UserCreationBody: Codable {
    let email: String
    let password: String
    let passwordConfirmation: String

    enum CodingKeys: String, CodingKey {
            case email
            case password
            case passwordConfirmation = "password_confirmation"
        }
}

struct UserCreationWrapper: Codable {
    let user: UserCreationBody
}

struct UserResponseError: Codable {
    let password: [String]?
    let passwordConfirmation: [String]?
    let email: [String]?
    
    enum CodingKeys: String, CodingKey {
            case email
            case password
            case passwordConfirmation = "password_confirmation"
        }

}

class Webservice {
    
    func login(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "http://localhost:3000/login") else {
            completion(.failure(.custom(errorMessage: "URL is incorrect")))
            return
        }
        
        let body = LoginRequestBody(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data found")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponseBody.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            completion(.success(token))
            
        }.resume()
    }
    
    func createUser(email: String, password: String, passwordConfirmation: String, completion: @escaping (Result<String, UserCreationError>) -> Void) {
        
        guard let url = URL(string: "http://localhost:3000/users") else {
            completion(.failure(.custom(errorMessage: "URL is incorrect")))
            return
        }
        
        let body = UserCreationWrapper(user: UserCreationBody(email: email, password: password, passwordConfirmation: passwordConfirmation))
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(.failure(.custom(errorMessage: "No data found")))
                return
            }
            guard let creationError = try? JSONDecoder().decode(UserResponseError.self, from: data) else {
                completion(.success("Account was successfully created"))
                return
            }
            var allMessages: [String] = []
            if let passwordConfirmationMessages = creationError.passwordConfirmation {
                allMessages.append("Password Confirmation:")
                allMessages.append(contentsOf: passwordConfirmationMessages)
            }
            if let emailMessages = creationError.email {
                allMessages.append("Email:")
                allMessages.append(contentsOf: emailMessages)
            }
            if let passwordMessages = creationError.password {
                allMessages.append("Password:")
                allMessages.append(contentsOf: passwordMessages)
            }
            completion(.failure(.custom(errorMessage: allMessages.joined(separator: "\n"))))
        }.resume()
    }
}
