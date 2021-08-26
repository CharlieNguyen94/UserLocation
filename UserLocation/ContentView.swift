//
//  ContentView.swift
//  UserLocation
//
//  Created by Charlie Nguyen on 26/08/2021.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

