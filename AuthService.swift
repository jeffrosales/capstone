//
//  AuthService.swift
//  CapstoneNationalUNI
//
//  Created by Jeff Rosales on 12/9/24.
//

import Foundation

enum AuthError: Error {
    case invalidCredentials
}

class AuthService {
    private var token: String?

    var hasValidToken: Bool {
        return token != nil
    }

    func login(username: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        print("AuthService.login() called with username: \(username), password: \(password)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if password == "mfa" {
                print("MFA required triggered")
                completion(.success(true)) // MFA required
            } else {
                self.token = "fake_token_value"
                print("No MFA required triggered. Token set.")
                completion(.success(false)) // No MFA required
            }
        }
    }

    func verifyMFA(code: String, completion: @escaping (Result<Void, Error>) -> Void) {
        print("AuthService.verifyMFA() called with code: \(code)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.token = "fake_token_value"
            print("MFA verification successful. Token set.")
            completion(.success(()))
        }
    }

    func logout() {
        token = nil
        print("AuthService: Token cleared on logout.")
    }
    
    class AuthService {
        private var token: String?
        private let networkService = NetworkService()

        var hasValidToken: Bool {
            return token != nil
        }

        func login(username: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
            let url = URL(string: "https://your-secure-server.com/login")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let bodyString = "username=\(username)&password=\(password)"
            request.httpBody = bodyString.data(using: .utf8)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            let task = networkService.session.dataTask(with: request) { data, response, error in
                // In a real scenario, parse `data` and check `response` to determine MFA requirement and token.
                // For demonstration, continue simulating:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if password == "mfa" {
                        completion(.success(true)) // MFA required
                    } else {
                        self.token = "fake_token_value"
                        completion(.success(false)) // No MFA required
                    }
                }
            }
            task.resume()
        }

        func verifyMFA(code: String, completion: @escaping (Result<Void, Error>) -> Void) {
            let url = URL(string: "https://your-secure-server.com/verifyMFA")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let bodyString = "mfa_code=\(code)"
            request.httpBody = bodyString.data(using: .utf8)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            let task = networkService.session.dataTask(with: request) { data, response, error in
                // Simulate MFA verification success.
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.token = "fake_token_value"
                    completion(.success(()))
                }
            }
            task.resume()
        }

        func logout() {
            token = nil
        }
    }}
