//
//  OnboardingView.swift
//  SwiftUI-Jam-2020
//
//  Created by Andreas on 2/19/21.
//

import SwiftUI

struct OnboardingView: View {
    @State var interests = [String]()
    @State var add: Bool = false
    @State var settings: Bool = false
    @State var show: Bool = false
   

        
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea(.all)
            TabView {
                OnboardingPage(titleText: "Welcome", bodyText: "This is Retro, an app to remind you of the past while building your future through music", image: "posture", show: $show)
                    .ignoresSafeArea(.all)
               
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            .transition(.opacity)
            .animation(.easeInOut(duration: 1.5))
            .ignoresSafeArea(.all)
            .onAppear() {
                MusicManager.shared.playFavoriteSong()
            }
       
        }
    }
}
