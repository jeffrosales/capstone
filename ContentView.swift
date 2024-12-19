//
//  ContentView.swift
//  CapstoneNationalUNI
//
//  Created by Jeff Rosales on 12/9/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()

                VStack {
                    Text("AirLink")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .padding()

                    Group {
                        switch authVM.state {
                        case .unauthenticated:
                            LoginView()
                        case .mfaRequired:
                            MFAView()
                        case .authenticated:
                            HomeView()
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            print("ContentView showing state: \(authVM.state)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel(authService: AuthService()))
    }
}
