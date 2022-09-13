//
//  SpotDataLogic.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 05/09/22.
//

import Foundation

extension AppData {
    
    func addSpot(_ spot: Spot) {
        self.spots.append(spot)
    }
    
    func removeSpot(with id: UUID) {
        self.spots.removeAll(where: {$0.id == id})
    }
    
}
