//
//  DepartureSelectionView.swift
//  CapstoneNationalUNI
//
//  Created by Jeff Rosales on 12/9/24.
//

import SwiftUI

struct DepartureSelectionView: View {
    @State private var selectedLocation = 0
    let departureLocations = ["Kadena AB", "Ramstein AB", "Travis AFB", "Andersen AFB", "Aviano AB"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Choose Departure Location")
                .font(.title)

            Picker("Select a location", selection: $selectedLocation) {
                ForEach(0..<departureLocations.count, id: \.self) { index in
                    Text(departureLocations[index]).tag(index)
                }
            }
            .pickerStyle(.menu)

            NavigationLink("Next") {
                FlightListView(departureBase: departureLocations[selectedLocation])
            }
            .padding()
        }
        .padding()
        .navigationTitle("Departure Location")
    }
}
