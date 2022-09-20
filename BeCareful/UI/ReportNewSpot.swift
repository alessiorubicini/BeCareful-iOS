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
    @ObservedObject var manager: LocationManager
    
    @State private var spot = Spot()
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.333747, longitude: -122.011448)
    @State private var coordinatesInput = false
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - View body
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("newSpot.info") {
                    TextField("newSpot.title", text: $spot.title)
                    
                    Picker("newSpot.type", selection: $spot.type) {
                        ForEach(SpotType.allCases, id: \.self) {
                            Text($0.localized).tag($0)
                        }
                    }.pickerStyle(.menu)
                    
                    LabeledContent("spot.danger") {
                        ForEach(1...3, id: \.self) { num in
                            Image(systemName: num <= spot.dangerLevel ? "circle.fill" : "circle").foregroundColor(.red)
                                .onTapGesture {
                                    withAnimation {
                                        self.spot.dangerLevel = num
                                    }
                                }
                        }
                    }
                }
                
                // Location input
                Section("newSpot.location") {
                    LocationPicker(instructions: "", coordinates: $coordinates)
                        .frame(height: 400)
                }.modifier(FormFree())
                
            }
            .navigationTitle("newSpot.viewTitle")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("buttons.cancel").foregroundColor(.red).fontWeight(.semibold)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.manager.data.spots.append(self.spot)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("buttons.confirm").fontWeight(.semibold)
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
        ReportNewSpot(manager: LocationManager())
    }
}
