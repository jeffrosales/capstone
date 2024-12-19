//
//  FlightListView.swift
//  CapstoneNationalUNI
//
//  Created by Jeff Rosales on 12/9/24.
//

import SwiftUI

struct Flight: Identifiable {
    let id = UUID()
    let destination: String
    let departureTime: String
    var seatsAvailable: Bool
}

struct FlightListView: View {
    let departureBase: String
    @State private var flights: [Flight] = [
        Flight(destination: "Yokota AB", departureTime: "10:00 AM", seatsAvailable: true),
        Flight(destination: "Hickam AFB", departureTime: "1:00 PM", seatsAvailable: false),
        Flight(destination: "Osan AB", departureTime: "3:30 PM", seatsAvailable: true),
        Flight(destination: "Misawa AB", departureTime: "6:00 PM", seatsAvailable: false),
        Flight(destination: "Spangdahlem AB", departureTime: "8:00 PM", seatsAvailable: true)
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Departure: \(departureBase)")
                .font(.title)

            List {
                ForEach(flights) { flight in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Destination: \(flight.destination)")
                            Text("Departs: \(flight.departureTime)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if flight.seatsAvailable {
                            Text("Available")
                                .foregroundColor(.green)
                        } else {
                            Text("No Seats")
                                .foregroundColor(.red)
                        }
                    }
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Flights")
    }
}
