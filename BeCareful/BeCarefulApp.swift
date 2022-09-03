//
//  BeCarefulApp.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import SwiftUI

@main
struct BeCarefulApp: App {
    
    // MARK: - View properties
    
    @StateObject var data = AppData()
    @StateObject var locationManager = LocationManager()
    
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    
    // MARK: - View body
    
    var body: some Scene {
        WindowGroup {
            LiveMapView(data: data, locationManager: locationManager)
                .sheet(isPresented: $isFirstLaunch) {
                    OnboardingView(isFirstLaunch: $isFirstLaunch)
                }
                .onAppear {
                    self.data.load()
                }
        }
    }
}
