//
//  RoutingView.swift
//  SwiftUI-Jam-2020
//
//  Created by Andreas on 2/21/21.
//

import SwiftUI

struct RoutingView: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        if userData.isOnboardingCompleted {
            ContentView()
            
        } else {
            OnboardingView()
                
        }
    }
}

struct RoutingView_Previews: PreviewProvider {
    static var previews: some View {
        RoutingView()
    }
}
