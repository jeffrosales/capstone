//
//  MFAView.swift
//  CapstoneNationalUNI
//
//  Created by Jeff Rosales on 12/14/24.
//

import SwiftUI

struct MFAView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("MFA Required")
                .font(.title)

            TextField("MFA Code", text: $authVM.mfaCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("Verify MFA") {
                print("MFA verify button tapped. Code: \(authVM.mfaCode)")
                authVM.verifyMFA()
            }
            .padding()
        }
        .padding()
    }
}

struct MFAView_Previews: PreviewProvider {
    static var previews: some View {
        MFAView()
            .environmentObject(AuthViewModel(authService: AuthService()))
    }
}
