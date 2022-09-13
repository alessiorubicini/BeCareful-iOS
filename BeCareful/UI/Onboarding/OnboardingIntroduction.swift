//
//  OnboardingIntroduction.swift
//  BeCareful
//
//  Created by Alessio Rubicini on 03/09/22.
//

import SwiftUI

struct OnboardingIntroduction: View {
    var body: some View {
        VStack(alignment: .center) {
            
            Text("onboarding.title")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("onboarding.description")
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct OnboardingIntroduction_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingIntroduction()
    }
}
