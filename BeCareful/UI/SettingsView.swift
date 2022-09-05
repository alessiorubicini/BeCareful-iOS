//
//  SettingsView.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - View properties
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - View body
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("settings.preferences")) {
                    
                }
                
                Section(header: Text("settings.info")) {
                    HStack {
                        Text("settings.version")
                        Spacer()
                        Text("\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)")
                    }
                    
                    NavigationLink(destination: EmptyView().navigationTitle("Privacy policy")) {
                        Label("settings.privacy.title", systemImage: "hand.raised.slash.fill")
                    }
                    
                    Button(action: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }, label: {
                        Label("settings.permissions", systemImage: "lock.shield.fill")
                    })
                    
                    Link(destination: URL(string: "http://alessiorubicini.altervista.org")!, label: {
                        Label("settings.contact", systemImage: "link")
                    }).accessibilityLabel(Text("settings.contact"))
                }
            }
            .navigationTitle("settings.viewTitle")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("buttons.ok").fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
