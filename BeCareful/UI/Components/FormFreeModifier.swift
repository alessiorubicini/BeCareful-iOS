//
//  FormFreeModifier.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 13/09/22.
//

import Foundation
import SwiftUI

struct FormFree: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .listRowInsets(EdgeInsets())
            .background(Color(UIColor.systemGroupedBackground))
    }
}
