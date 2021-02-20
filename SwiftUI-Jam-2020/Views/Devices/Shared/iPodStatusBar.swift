//
//  iPodStatusBar.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import SwiftUI

struct iPodStatusBar: View {
    @Environment(\.colorScheme) private var colorScheme
    var title: String = "iPod"

    private var lightMode: Bool {
        colorScheme == .light
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
            Spacer()
            Image(systemName: "lock.fill")
                .font(.caption)
            playIcon
            battery
        }
        .padding(6)
        .background(background)
    }

    private var playIcon: some View {
        PlayShape()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color(.cyan), Color.blue]),
                    startPoint: .topTrailing, endPoint: .leading
                )
            )
            .frame(width: 10, height: 10)
            .overlay(PlayShape().stroke(lineWidth: 0.5))
    }

    private var battery: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.white, .green]),
                        startPoint: .top, endPoint: .bottom
                    )
                )
                .frame(width: 18, height: 10)
                .overlay(Rectangle().stroke(lineWidth: 0.5))
            Rectangle()
                .fill(Color.green)
                .frame(width: 2, height: 5)
                .overlay(Rectangle().stroke(lineWidth: 0.5))
        }
    }

    private var background: some View {
        Color.secondarySystemFill
            .overlay(
                LinearGradient(
                    gradient: Gradient(
                        colors: [.secondarySystemBackground, .secondarySystemFill]),
                    startPoint: .top, endPoint: .bottom
                )
            )
    }
}

struct iPodStatusBar_Previews: PreviewProvider {
    static var previews: some View {
        iPodStatusBar()
    }
}
