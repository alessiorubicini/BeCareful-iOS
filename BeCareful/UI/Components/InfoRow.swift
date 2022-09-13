//
//  InfoRow.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import SwiftUI

struct InfoRow: View {
    
    let key: LocalizedStringKey
    let value: String
    
    var body: some View {
        HStack {
            Text(key).fontWeight(.semibold)
            Spacer()
            Text(value)
        }
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(key: "1", value: "2")
    }
}
