//
//  MyApp.swift
//  CapstoneNationalUNI
//
//  Created by Jeff Rosales on 12/14/24.
//

import SwiftUI

@main
struct MyApp: App {
    @StateObject var authViewModel = AuthViewModel(authService: AuthService())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
