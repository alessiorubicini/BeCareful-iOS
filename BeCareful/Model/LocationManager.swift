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
    @Published var data = AppData()
    let manager = CLLocationManager()
    
    @Published var currentLocation: CLLocation?
    @Published var nearStatus = (false, "", 0.0)
    
    override init() {
        super.init()
        self.data = AppData()
        
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
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("---> Current location: \(manager.location!.coordinate.latitude), \(manager.location!.coordinate.longitude)")
        self.checkDistance()
    }
    
    func checkDistance() {
        
        for spot in data.spots {
            
            let distance = manager.location!.distance(from: CLLocation(latitude: spot.coordinate.latitude, longitude: spot.coordinate.longitude))
            
            if distance.isLess(than: 150.0) {
                
                let message = "Attenzione, \(spot.type.rawValue) a \(round(distance * 10) / 10.0) metri da te"
                print(message)
                
                if self.nearStatus.0 == false {
                    
                    // Send notification

                    
                    // Generate custom haptic feedback
                    
                    
                }
                
                self.nearStatus = (true, spot.type.localized, distance)
            }
        }
        
    }
    
}
