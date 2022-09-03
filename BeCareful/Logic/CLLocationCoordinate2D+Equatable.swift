//
//  CLLocationCoordinate2D+Equatable.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        if lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude {
            return true
        } else {
            return false
        }
    }
}
