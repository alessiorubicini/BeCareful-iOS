//
//  StatusCapsule.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 17/09/22.
//

import SwiftUI

struct StatusCapsule: View {
    
    let status: LocalizedStringKey
    
    var body: some View {
        Text(status)
            .padding(.vertical, 7)
            .frame(minWidth: 120)
            .background(status.toString().contains("Go on") ? Color.green : Color.red)
            .foregroundColor(.white)
            .hoverEffect(.lift)
            .clipShape(Capsule())
    }
}

struct StatusCapsule_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StatusCapsule(status: "mapView.payAttention")
            StatusCapsule(status: "mapView.goOn")
        }
        
    }
}
