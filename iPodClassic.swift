//
//  iPodClassic.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import SwiftUI
import SwiftUIX

struct iPodClassic: View {
    @State private var menuIndex: Int = 0
    @Environment(\.colorScheme) private var colorScheme

    private var lightMode: Bool {
        colorScheme == .light
    }

    var body: some View {
        VStack(spacing: 0) {
            Display(menuIndex: $menuIndex)
            Spacer()
            iPodClickWheel(menuIndex: $menuIndex)
            Spacer()
        }
        .padding(24)
        .background(lightMode ? Color.secondarySystemFill : Color.systemFill)
        .tRoundCorners(32)
        .shadow(color: Color.black.opacity(0.15), radius: 24, x: 0, y: 2)
        .overlay(
            CustomRoundedRectangle(radius: 32)
                .stroke(Color.clear, lineWidth: 8)
                .shadow(color: Color.black.opacity(lightMode ? 0.3 : 0.9), radius: 12, x: 0, y: 0)
                .tRoundCorners(32)
        )
    }

    struct Display: View {
        @Binding var menuIndex: Int
        @State private var move: Bool = false

        var body: some View {
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        iPodStatusBar()
                        iPodMenu(menuIndex: $menuIndex)
                    }

                    Image("abbeyRoad")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.width / 2)
                        .frame(maxHeight: .infinity)
                        .offset(x: imageOffset(for: proxy.width))
                        .clipped()
                        .overlay(shadowOverlay)
                        .onAppear(perform: startImageAnimation)
                }
            }
            .tRoundCorners()
            .overlay(thickBorder)
        }

        private var shadowOverlay: LinearGradient {
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.4)]), startPoint: .center, endPoint: .leading)
        }

        private var thickBorder: some View {
            CustomRoundedRectangle(radius: 8)
                .stroke(Color.black, lineWidth: 4)
        }

        private func imageOffset(for width: CGFloat) -> CGFloat {
            move ? -width / 16 : width / 16
        }

        private func startImageAnimation() {
            withAnimation(Animation.linear(duration: 8).repeatForever(autoreverses: true)) {
                move = true
            }
        }
    }
}

//
// struct iPod_Previews: PreviewProvider {
//    static var previews: some View {
//        iPodClassic()
//    }
// }
