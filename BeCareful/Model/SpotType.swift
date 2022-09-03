//
//  SpotType.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import Foundation
import SwiftUI

enum SpotType: String, Identifiable, Codable, CaseIterable {
    var id: RawValue { rawValue }
    
    case poorVisibility = "Scarsa visiblità"
    case rainDanger = "Pericolo pioggia"
    case railroadCrossing = "Passaggio a livello"
    case trafficSignsNotVisible = "Segnali ostruiti o rovinati"
    case crossWalk = "Attraversamento pedonale"
    case cycleCrossing = "Attraversamento ciclabile"
    case narrowStreet = "Strada stretta"
    case narrowParking = "Parcheggio stretto"
    case dangerousOvertaking = "Sorpasso pericoloso"
    case dangerousInversion = "Inversione pericolosa"
    
    var icon: some View {
        switch self {
            case .poorVisibility: return Image(systemName: "eye.slash.circle.fill").foregroundColor(.red)
            case .rainDanger: return Image(systemName: "cloud.drizzle.fill").foregroundColor(.red)
            case .railroadCrossing: return Image(systemName: "tram.circle.fill").foregroundColor(.red)
            case .trafficSignsNotVisible: return Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.orange)
            case .crossWalk: return Image(systemName: "figure.walk.circle.fill").foregroundColor(.blue)
            case .cycleCrossing: return Image(systemName: "bicycle.circle.fill").foregroundColor(.blue)
            case .narrowStreet: return Image(systemName: "car.circle.fill").foregroundColor(.blue)
            case .narrowParking: return Image(systemName: "p.circle.fill").foregroundColor(.blue)
            case .dangerousOvertaking: return Image(systemName: "car.2.fill").foregroundColor(.red)
            case .dangerousInversion: return Image(systemName: "arrow.uturn.down.circle.fill").foregroundColor(.red)
        }
    }
}
