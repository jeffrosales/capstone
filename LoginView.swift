//
//  LoginView.swift
//  CapstoneNationalUNI
//
//  Created by Jeff Rosales on 12/14/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.title)

            TextField("Username", text: $authVM.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            SecureField("Password", text: $authVM.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("Login") {
                print("Login button tapped")
                print("Username: \(authVM.username), Password: \(authVM.password)")
                authVM.login()
            }
            .padding()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel(authService: AuthService()))
    }
}
