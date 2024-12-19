//
//  HomeView.swift
//  CapstoneNationalUNI
//
//  Created by Jeff Rosales on 12/14/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        VStack(spacing: 40) {
            HStack(spacing: 40) {
                NavigationLink(destination: DepartureSelectionView()) {
                    IconButton(iconName: "location.fill", label: "Location")
                }

                NavigationLink(destination: ContactUsView()) {
                    IconButton(iconName: "envelope.fill", label: "Contact Us")
                }
            }

            HStack(spacing: 40) {
                NavigationLink(destination: FlightListView(departureBase: "Kadena AB")) {
                    IconButton(iconName: "airplane", label: "Flights")
                }

                if authVM.role == .admin {
                    NavigationLink(destination: DocumentsView()) {
                        IconButton(iconName: "doc.text.fill", label: "Documents")
                    }
                } else {
                    Text("No Admin Access")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }

            Button("Logout") {
                authVM.logout()
            }
            .padding(.top, 40)
        }
        .padding()
        .navigationBarHidden(true)
    }
}

struct IconButton: View {
    let iconName: String
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
            Text(label)
                .font(.footnote)
        }
    }
}
