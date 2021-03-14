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
        if !show {
            OnboardingPage(titleText: "Welcome", bodyText: "This is Retro, an app to remind you of the past while building your future through music", image: "posture", show: $show, nextCount: $nextCount)
                .background(Color.systemBackground)
                .onAppear {
                    MusicManager.shared.playFavoriteSong()
                }
                .onChange(of: nextCount, perform: { _ in
                    if nextCount == 1 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                           
                                show = true
                        
                        }
                    }
                })

        } else {
            ContentView()
                .transition(.opacity)
        }
    }
}
