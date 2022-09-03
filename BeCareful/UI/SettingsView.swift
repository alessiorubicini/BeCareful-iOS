//
//  SettingsView.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section(header: Text("Preferenze")) {
                
            }
            
            Section(header: Text("Informazioni")) {
                InfoRow(key: "Versione", value: "1.0.0")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
