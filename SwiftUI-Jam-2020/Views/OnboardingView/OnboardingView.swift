//
//  OnboardingView.swift
//  SwiftUI-Jam-2020
//
//  Created by Andreas on 2/20/21.
//

import SwiftUI

struct OnboardingView: View {

    @State var show: Bool = false
   
   @State var nextCount = 0
        
    
    var body: some View {
        ZStack {
            Color.systemBackground
                .ignoresSafeArea(.all)
            //TabView {
            
                OnboardingPage(titleText: "Welcome", bodyText: "This is Retro, an app to remind you of the past while building your future through music", image: "posture", show: $show, nextCount: $nextCount)
                    //.ignoresSafeArea(.all)
                    .onAppear() {
                        MusicManager.shared.playFavoriteSong()
                    }
                    .onChange(of: nextCount, perform: { value in
                        if nextCount == 1 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                                withAnimation(.linear(duration: 0.1)) {
                                show = true
                                }
                            }
                        }
                    })
            if show {
                
                ContentView()
                    .transition(.opacity)
                   
            }
            
            //}.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
           //.transition(.opacity)
           // .animation(.easeInOut(duration: 1.5))
            //.ignoresSafeArea(.all)
           
       
        }
    }
}
