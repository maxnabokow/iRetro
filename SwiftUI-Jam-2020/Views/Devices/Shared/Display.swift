//
//  Display.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/20/21.
//

import SwiftUI

struct Display: View {
    @StateObject private var vm = DisplayViewModel()
    @State private var move: Bool = false
    private let animateCover: Bool = false

    var body: some View {
        NavigationView { // Full Screen Navigation View
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        StatusBar()
                        MainMenu()
                    }

                    Image("abbeyRoad")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.width / 2)
                        .frame(maxHeight: .infinity)
                        .if(animateCover) {
                            $0.offset(x: coverOffset(for: proxy.width))
                        }
                        .clipped()
                        .overlay(shadowOverlay)
                        .if(animateCover) {
                            $0.onAppear(perform: startCoverAnimation)
                        }
                }
            }
            .navigationBarHidden(true)
            .overlay(
                NavigationLink(destination: vm.fullScreenView, isActive: $vm.showFullScreen, label: {
                    EmptyView()
                })
            )
        }
        .tRoundCorners()
        .overlay(thickBorder)
        .onAppear(perform: vm.startListeningToFullScreenNotifications)
    }

    private var thickBorder: some View {
        CustomRoundedRectangle(radius: 8)
            .stroke(Color.black, lineWidth: 4)
    }

    private var shadowOverlay: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.4)]), startPoint: .center, endPoint: .leading)
    }

    private func coverOffset(for width: CGFloat) -> CGFloat {
        move ? -width / 16 : width / 16
    }

    private func startCoverAnimation() {
        withAnimation(Animation.linear(duration: 8).repeatForever(autoreverses: true)) {
            move = true
        }
    }
}
