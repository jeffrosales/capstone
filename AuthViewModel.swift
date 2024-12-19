






import SwiftUI

class AuthViewModel: ObservableObject {
    enum AuthState {
        case unauthenticated
        case mfaRequired
        case authenticated
    }

    enum UserRole {
        case user
        case admin
    }

    @Published var state: AuthState = .unauthenticated
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var mfaCode: String = ""
    @Published var role: UserRole = .user

    private let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
        checkExistingSession()
    }

    func checkExistingSession() {
        if authService.hasValidToken {
            assignRole()
            state = .authenticated
            print("Existing session found. State: authenticated, Role: \(role)")
        } else {
            state = .unauthenticated
            print("No valid token. State: unauthenticated")
        }
    }

    func login() {
        print("AuthViewModel.login() called with username: \(username), password: \(password)")
        authService.login(username: username, password: password) { result in
            DispatchQueue.main.async {
                print("AuthService.login completion: \(result)")
                switch result {
                case .success(let requiresMFA):
                    if requiresMFA {
                        self.state = .mfaRequired
                        print("State changed to mfaRequired")
                    } else {
                        self.assignRole()
                        self.state = .authenticated
                        print("State changed to authenticated, role: \(self.role)")
                    }
                case .failure(let error):
                    print("Login failed: \(error)")
                    self.state = .unauthenticated
                }
            }
        }
    }

    func verifyMFA() {
        print("AuthViewModel.verifyMFA() called with code: \(mfaCode)")
        authService.verifyMFA(code: mfaCode) { result in
            DispatchQueue.main.async {
                print("AuthService.verifyMFA completion: \(result)")
                switch result {
                case .success:
                    self.assignRole()
                    self.state = .authenticated
                    print("MFA success. State: authenticated, Role: \(self.role)")
                case .failure(let error):
                    print("MFA failed: \(error)")
                    self.state = .mfaRequired
                }
            }
        }
    }

    func logout() {
        authService.logout()
        state = .unauthenticated
        username = ""
        password = ""
        mfaCode = ""
        role = .user
        print("User logged out. State: unauthenticated")
    }

    private func assignRole() {
        self.role = (self.username.lowercased() == "admin") ? .admin : .user
        print("Role assigned: \(self.role) for username: \(self.username)")
    }
}
