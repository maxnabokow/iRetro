//
//  iPodClassic.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import SwiftUI
import SwiftUIX

struct iPodClassic: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var isOnboarding = true
    private var lightMode: Bool {
        colorScheme == .light
    }

    var body: some View {
        VStack(spacing: 0) {
            if !isOnboarding {
                iPodDisplay()
            } else {
                OnboardingiPodDisplay()
            }
            Spacer()
            iPodClickWheel()
            Spacer()
        }
        .padding(24)
        .background(lightMode ? Color.secondarySystemFill : Color.systemFill)
        .tRoundCorners(isOnboarding ? 0 : 32)
        .shadow(color: Color.black.opacity(0.15), radius: 24, x: 0, y: 2)
        .overlay(
            CustomRoundedRectangle(radius: 32)
                .stroke(Color.clear, lineWidth: 8)
                .shadow(color: Color.black.opacity(lightMode ? 0.3 : 0.9), radius: 12, x: 0, y: 0)
                .tRoundCorners(isOnboarding ? 0 : 32)
        )
    }
}
