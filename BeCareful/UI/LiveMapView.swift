//
//  LiveMapView.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import SwiftUI

import MapKit
import CoreLocation
import Combine

struct LiveMapView: View {
    
    // MARK: - View properties
    
    @ObservedObject var data: AppData
    @ObservedObject var locationManager: LocationManager
    
    @State private var cancellable: AnyCancellable?
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    
    @State private var addSheet = false
    @State private var newSpot = Spot()
    @State private var spotSheet = false
    @State private var spotSheetContent: Spot? = nil
    
    @State private var showSettings = false
    
    // MARK: - View body
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                if locationManager.manager.location != nil {
                    
                    ZStack {

                        // Map view
                        Map(coordinateRegion: $locationManager.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: locationManager.spots) { location in
                            
                            // Spot symbol on map
                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)) {
                                
                                VStack {
                                    location.type.icon.font(.title3)
                                }.foregroundColor(location.color)
                                
                                // On tap open sheet with spot's info
                                .onTapGesture(count: 1, perform: {
                                    self.spotSheetContent = location
                                    self.spotSheet.toggle()
                                })
                            }
                            
                        }
                        .edgesIgnoringSafeArea(.bottom)
                        
                        .sheet(isPresented: $spotSheet) {
                            if let spot = spotSheetContent {
                                SpotView(spot: spot)
                            }
                        }
                        
                        // Current user status
                        VStack {
                            Text(locationManager.nearStatus.0 ? "Attenzione: \(locationManager.nearStatus.1) a \(locationManager.nearStatus.2, specifier: "%.0f") metri da te" : "Nessun punto pericoloso nelle vicinanze (150 metri)")
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(locationManager.nearStatus.0 ? Color.red : Color.primary)
                                .padding().padding(.horizontal)
                                .background(.ultraThinMaterial).cornerRadius(10)
                                
                            Spacer()
                            
                        }.padding()
                        
                            .sheet(isPresented: $showSettings) {
                                SettingsView()
                            }
                        
                    }
                    
                    
                    
                } else {
                    VStack(alignment: .center) {
                        Spacer()
                        
                        Text("Caricamento della mappa in corso")
                            .fontWeight(.semibold)
                        
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        
                        Text("Se il caricamento persiste potrebbero esserci problemi nella localizzazione tramite GPS.\nControlla nelle impostazioni dell'app che i permessi siano stati forniti").padding()
                        
                        Spacer()
                    }.multilineTextAlignment(.center)
                }
                    
            }
            
            .sheet(isPresented: $addSheet) {
                ReportNewSpot(spot: $newSpot)
            }
            
            
            .navigationTitle("SafeDrive")
            .navigationBarTitleDisplayMode(.inline)
        
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.showSettings.toggle()
                }) {
                    Image(systemName: "gearshape").font(.system(size: 18)).foregroundColor(.blue)
                }
            }
            
            ToolbarItemGroup(placement: .bottomBar) {
                HStack {
                    
                    Button(action: {
                        withAnimation {
                            self.setCurrentLocation()
                        }
                    }, label: {
                        Image(systemName: "location.fill.viewfinder")
                    }).padding(.horizontal, 10)
                    
                    Spacer()
                    
                    Button(action: {
                        self.addSheet.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    }).padding(.leading, 10)
                    
                }
            }
        }
    }
    
    // Set current location on user's position
    private func setCurrentLocation() {
        print("Setting current location")
        cancellable = locationManager.$currentLocation.sink { location in
            self.region = MKCoordinateRegion(center: self.locationManager.manager.location?.coordinate ?? CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        }
    }
    
}

struct LiveMapView_Previews: PreviewProvider {
    static var previews: some View {
        LiveMapView(data: AppData(), locationManager: LocationManager())
    }
}
