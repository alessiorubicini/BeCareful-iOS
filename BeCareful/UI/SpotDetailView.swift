//
//  SpotDetailView.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 13/09/22.
//

import SwiftUI

struct SpotDetailView: View {
    
    // MARK: - View properties
    let spot: Spot
    @ObservedObject var manager: LocationManager
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - View body
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text(spot.title).fontWeight(.bold)
                
                Spacer()
                
                Group {
                    Image(systemName: "square.and.arrow.up.circle")
                    Image(systemName: "xmark.circle")
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                .foregroundColor(.secondary)
            }.font(.largeTitle).padding(.top).padding(.horizontal)
            
            Divider().padding(.horizontal)
            
            HStack {
                Group {
                    Text(spot.type.localized)
                    spot.type.icon
                }.font(.title3)
            }.padding(.vertical, 10).padding(.horizontal)
            
            Divider().padding(.horizontal)
            
            LabeledContent("spot.danger") {
                ForEach(1...3, id: \.self) { num in
                    if num <= spot.dangerLevel {
                        Image(systemName: "circle.fill").foregroundColor(.red)
                    } else {
                        Image(systemName: "circle").foregroundColor(.red)
                    }
                }
            }.font(.title3).padding()
            
            Spacer()
            
        }
    }
}

struct SpotDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Map View")
            .sheet(isPresented: .constant(true)) {
                SpotDetailView(spot: Spot.mocks[0], manager: LocationManager())
                    .presentationDetents([.height(300)])
            }
    }
}
