//
//  DeviceSides.swift
//  SwiftUI-Jam-2020
//
//  Created by Andreas on 2/20/21.
//

import SwiftUI

struct DeviceSides: View {
    @Environment(\.colorScheme) private var colorScheme

    private var lightMode: Bool {
        colorScheme == .light
    }

    var body: some View {
        Color.clear
//        .padding(24)
//        .background(lightMode ? Color.secondarySystemFill : Color.systemFill)
//        .tRoundCorners(32)
//        .shadow(color: Color.black.opacity(0.15), radius: 24, x: 0, y: 2)
//        .overlay(
//            CustomRoundedRectangle(radius: 32)
//                .stroke(Color.clear, lineWidth: 8)
//                .shadow(color: Color.black.opacity(lightMode ? 0.3 : 0.9), radius: 12, x: 0, y: 0)
//                .tRoundCorners(32)
//        )
    }
}
