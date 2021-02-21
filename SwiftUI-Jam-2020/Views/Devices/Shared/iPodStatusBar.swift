//
//  iPodStatusBar.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import Combine
import MediaPlayer
import SwiftUI

struct iPodStatusBar: View {
    @Environment(\.colorScheme) private var colorScheme

    @State private var playState: MPMusicPlaybackState = .stopped

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

            if playState != .stopped {
                playIcon
                    .frame(width: 10, height: 10)
            }

            battery
        }
        .padding(6)
        .background(background)
        .onAppear(perform: startPlayStateSubscription)
    }

    @State private var sinks = Set<AnyCancellable>()

    private func startPlayStateSubscription() {
        playState = MusicManager.shared.playState
        MusicManager.shared.playStateChanged()
            .receive(on: RunLoop.main)
            .sink { state in
                self.playState = state
            }
            .store(in: &sinks)
    }

    private var playIcon: some View {
        switch playState {
        case .playing: return AnyView(PlayShape().withGradient())
        case .paused, .interrupted: return AnyView(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color(.cyan), Color.blue]),
                    startPoint: .top, endPoint: .bottom
                )
                .mask(
                    Image(systemName: "pause.fill")
                )
            )
        default: return AnyView(PlayShape().withGradient())
        }
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
                .frame(width:  CGFloat(BatteryManager.shared.getBatteryLevel()*300/18), height: 10)
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

extension Shape {
    func withGradient() -> some View {
        fill(
            LinearGradient(
                gradient: Gradient(colors: [Color(.cyan), Color.blue]),
                startPoint: .topTrailing, endPoint: .leading
            )
        )
        .overlay(stroke(lineWidth: 0.5))
    }
}
