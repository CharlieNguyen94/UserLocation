//
//  MapViewModel.swift
//  MapViewModel
//
//  Created by Charlie Nguyen on 26/08/2021.
//

import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 51.5074, longitude: 0.1278)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation,
                                               span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Show an alert letting them")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Show alert: your location is restricted likely due to parental controls")
        case .denied:
            print("Rejected, change settings to fix")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: MapDetails.defaultSpan)
            print(region)
        @unknown default:
            break
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
