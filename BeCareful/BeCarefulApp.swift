//
//  BeCarefulApp.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import SwiftUI

@main
struct BeCarefulApp: App {
    @StateObject var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            LiveMapView(locationManager: locationManager)
        }
    }
}
