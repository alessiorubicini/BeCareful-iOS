//
//  OnboardingSetup.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import SwiftUI
import CoreLocation

struct OnboardingSetup: View {
    
    // MARK: - View properties
    
    @Binding var isFirstLaunch: Bool
    let locationManager = CLLocationManager()
    
    // MARK: - View body
    
    var body: some View {
        VStack {
            
            Image(systemName: "shield.fill").font(.system(size: 100)).foregroundColor(.accentColor).shadow(radius: 10)
            
            Text("onboarding.permits").padding()
            
            Button(action: {
                locationManager.requestAlwaysAuthorization()
            }, label: {
                Label("onboarding.allowGPS", systemImage: "location.fill.viewfinder").frame(maxWidth: 300)
                    .foregroundColor(.accentColor)
                
            }).buttonStyle(.bordered)
                .buttonStyle(.borderedProminent).controlSize(.large)
                .disabled(locationManager.authorizationStatus == .authorizedAlways)
                .padding(.vertical, 20)
            
            
            Button(action: {
                
                // Set onboarding value
                self.isFirstLaunch = false
                
            }, label: {
                Text("onboarding.proceed").fontWeight(.semibold).frame(maxWidth: 300)
            }).buttonStyle(.borderedProminent).controlSize(.large)
                .padding(.vertical, 20)
            
        }
    }

}

struct OnboardingSetup_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSetup(isFirstLaunch: .constant(true))
    }
}
