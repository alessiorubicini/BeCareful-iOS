//
//  LocationManager.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion()
    let manager = CLLocationManager()
    
    @Published var currentLocation: CLLocation?
    @Published var spots: [Spot] = []
    @Published var nearStatus = (false, "", 0.0)
    
    override init() {
        super.init()
        
        if(self.manager.authorizationStatus == CLAuthorizationStatus.denied) {
            
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            
        } else if (self.manager.authorizationStatus == CLAuthorizationStatus.notDetermined) {
            
            manager.requestAlwaysAuthorization()
            
        } else {
            
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.distanceFilter = kCLDistanceFilterNone
            manager.requestAlwaysAuthorization()
            manager.startUpdatingLocation()
            
        }
        
        //self.fetchNearSpots()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if spots.count == 0 {
            self.nearStatus = (false, "", 0.0)
        }
        
        print("----------------------------------")
        print("Current location: \(manager.location!.coordinate.latitude), \(manager.location!.coordinate.longitude)")
        
        //self.checkDistance()
        
    }
}
