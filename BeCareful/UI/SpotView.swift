//
//  SpotView.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import SwiftUI
import MapKit
import CoreLocation

struct SpotView: View {
    
    // MARK: - View properties
    let spot: Spot
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - View body
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Posizione")) {
                    
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))), annotationItems: [spot]) { location in
                        
                        MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), tint: .red)
                    }
                    .frame(height: 300)
                
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .listRowInsets(EdgeInsets())
                    .background(Color(UIColor.systemGroupedBackground))
                
                Section(header: Text("Informazioni")) {
                    
                    InfoRow(key: "Nome", value: spot.name)
                    
                    HStack {
                        Text("Tipo").fontWeight(.semibold)
                        Spacer()
                        Text(spot.type.rawValue)
                        spot.type.icon
                    }
                    
                    HStack {
                        Text("Pericolosità").fontWeight(.semibold)
                        Spacer()
                        HStack {
                            ForEach(1...3, id: \.self) { num in
                                if num <= spot.dangerLevel {
                                    Image(systemName: "circle.fill").foregroundColor(.red)
                                } else {
                                    Image(systemName: "circle").foregroundColor(.red)
                                }
                            }
                        }
                    }
                    
                }
                
            }
            .navigationTitle("Punto selezionato")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Fine").fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

struct SpotView_Previews: PreviewProvider {
    static var previews: some View {
        SpotView(spot: Spot.mocks[0])
    }
}
