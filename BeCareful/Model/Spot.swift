//
//  Spot.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import Foundation
import MapKit
import SwiftUI

struct Spot: Identifiable, Codable {
    
    let id: UUID
    var name: String
    var type: SpotType
    var dangerLevel: Int
    var latitude: Double
    var longitude: Double
    var address: String
    
    init(id: UUID = UUID(), name: String = "", type: SpotType = .crossWalk, danger: Int = 1, lat: Double = 37.333, long: Double = -122.006, address: String = "") {
        self.id = id
        self.name = name
        self.type = type
        self.dangerLevel = danger
        self.latitude = lat
        self.longitude = long
        self.address = address
    }
    
}

extension Spot {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    var color: Color {
        switch self.type {
        case .poorVisibility: return Color.red
        case .rainDanger: return Color.red
        case .railroadCrossing: return Color.red
        case .trafficSignsNotVisible: return Color.orange
        case .crossWalk: return Color.blue
        case .cycleCrossing: return Color.blue
        case .narrowStreet: return Color.blue
        case .narrowParking: return Color.blue
        case .dangerousOvertaking: return Color.red
        case .dangerousInversion: return Color.red
        }
    }
    
    static let mocks = [
        Spot(id: UUID(), name: "Incrocio", type: .poorVisibility, danger: 1, lat: 37.331660, long: -122.032235, address: "Infinite Loop, Cupertino, CA 95014, Stati Uniti")
    ]
    
}
