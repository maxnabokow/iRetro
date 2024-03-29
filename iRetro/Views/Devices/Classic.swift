//
//  Classic.swift
//  iRetro
//
//  Created by Max Nabokow on 2/19/21.
//

import SwiftUI
import SwiftUIX

struct Classic: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var isOnboarding = false
    var namespace: Namespace.ID?

    let width: CGFloat?

    private var lightMode: Bool {
        colorScheme == .light
    }

    var body: some View {
        VStack(spacing: 0) {
            if !isOnboarding {
                ClassicDisplay()
                    .if(namespace != nil) {
                        $0.matchedGeometryEffect(id: "display", in: namespace!)
                    }
            } else {
                OnboardingDeviceDisplay()
            }
            Spacer()
            ClickWheel()
                .if(namespace != nil) {
                    $0.matchedGeometryEffect(id: "clickwheel", in: namespace!)
                }
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
        .if(width != nil) {
            $0.frame(width: width!, height: width! * 1.8)
        }
    }
}
