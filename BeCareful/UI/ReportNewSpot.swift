//
//  ReportNewSpot.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import SwiftUI
import LocationPicker
import MapKit

struct ReportNewSpot: View {
    
    // MARK: - View properties
    @Binding var spot: Spot
    
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.333747, longitude: -122.011448)

    @State private var coordinatesInput = false
    
    // MARK: - View body
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Informazioni")) {
                    TextField("Nome", text: $spot.name)
                    
                    HStack {
                        Text("Tipo")
                        Spacer()
                        Picker("", selection: $spot.type) {
                            ForEach(SpotType.allCases, id: \.self) {
                                Text($0.rawValue)
                                    .tag($0)
                            }
                        }.pickerStyle(.menu)
                    }
                }
                
                Section(header: Text("Posizione")) {
                    
                    LocationPicker(instructions: "Inserisci le coordinate", coordinates: $coordinates)
                        .frame(height: 400)
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .listRowInsets(EdgeInsets())
                    .background(Color(UIColor.systemGroupedBackground))
                
            }
            .navigationTitle("Nuovo punto")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Text("Annulla").foregroundColor(.red).fontWeight(.semibold)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Aggiungi").fontWeight(.semibold)
                    }
                }
            }
            
            .onChange(of: self.coordinates) { newCoordinates in
                self.spot.latitude = newCoordinates.latitude
                self.spot.longitude = newCoordinates.longitude
            }
        }
        
    }
}

struct ReportNewSpot_Previews: PreviewProvider {
    static var previews: some View {
        ReportNewSpot(spot: .constant(Spot.mocks[0]))
    }
}
