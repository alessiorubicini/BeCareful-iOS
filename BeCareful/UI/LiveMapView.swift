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
    
    @ObservedObject var locationManager: LocationManager
    
    @State private var cancellable: AnyCancellable?
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    
    @State private var addSheet = false
    @State private var spotSheet = false
    @State private var selectedSpot: Spot? = nil
    
    @State private var showSettings = false
    
    // MARK: - View body
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                if locationManager.manager.location != nil {
                    
                    ZStack {

                        // Map view
                        Map(coordinateRegion: $locationManager.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: locationManager.data.spots) { location in
                            
                            // Spot symbol on map
                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)) {
                                
                                VStack {
                                    location.type.icon.font(.title)
                                }.foregroundColor(location.color)
                                
                                // On tap open sheet with spot's info
                                .onTapGesture(count: 1, perform: {
                                    self.selectedSpot = location
                                    self.spotSheet.toggle()
                                })
                            }
                            
                        }
                        
                        .sheet(isPresented: $spotSheet) {
                            if let spot = selectedSpot {
                                SpotDetailView(spot: spot, manager: self.locationManager)
                                    .presentationDetents([.height(350)])
                            }
                        }
                        
                        // Current user status
                        VStack {
                            Text(locationManager.nearStatus.0 ? "mapView.dangerousSpot \(locationManager.nearStatus.1.lowercased()) \(locationManager.nearStatus.2, specifier: "%.0f")" : "mapView.noDangerousSpots")
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(locationManager.nearStatus.0 ? Color.red : Color.primary)
                                .padding().padding(.horizontal)
                                .background(.thinMaterial).cornerRadius(10)
                                
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
                ReportNewSpot(manager: self.locationManager)
            }
            .navigationBarTitleDisplayMode(.inline)
            
            .onAppear {
                self.locationManager.data.load()
            }
         
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation {
                            self.setCurrentLocation()
                        }
                    }, label: {
                        Image(systemName: "location.fill.viewfinder")
                    }).padding(.horizontal, 10)
                }
                
                ToolbarItem(placement: .principal) {
                    if locationManager.nearStatus.0 {
                        Text("mapView.payAttention")
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                            
                    } else {
                        Text("mapView.goOn")
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                    }
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    HStack {
                        
                        Button(action: {
                            self.showSettings.toggle()
                        }) {
                            Image(systemName: "gearshape")
                        }
                        
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
    }
    
    // Set current location on user's position
    private func setCurrentLocation() {
        cancellable = locationManager.$currentLocation.sink { location in
            self.region = MKCoordinateRegion(center: self.locationManager.manager.location?.coordinate ?? CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        }
    }
    
}

struct LiveMapView_Previews: PreviewProvider {
    static var previews: some View {
        LiveMapView(locationManager: LocationManager())
    }
}
