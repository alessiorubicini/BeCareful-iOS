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
    
    let spot: Spot
    
    var body: some View {
        List {
            
            Section(header: Text("Posizione")) {
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))), annotationItems: [spot]) { location in
                    
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), tint: .red)
                }
                .frame(width: 310, height: 300)
                .cornerRadius(10)
                    
            }
            
            Section(header: Text("Informazioni")) {
                InfoRow(key: "Nome", value: spot.name)
                HStack {
                    Text("Tipo").fontWeight(.semibold)
                    Spacer()
                    Text(spot.type.rawValue)
                    spot.type.icon
                }
                
                HStack {
                    Text("Livello pericolosità").fontWeight(.semibold)
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
    }
}

struct InfoRow: View {
    
    let key: String
    let value: String
    
    var body: some View {
        HStack {
            Text(key).fontWeight(.semibold)
            Spacer()
            Text(value)
        }
    }
}

struct SpotView_Previews: PreviewProvider {
    static var previews: some View {
        SpotView(spot: Spot.mocks[0])
    }
}
