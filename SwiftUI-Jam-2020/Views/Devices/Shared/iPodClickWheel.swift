//
//  iPodClickWheel.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import Combine
import SwiftUI

class ClickWheelService {
    static let shared = ClickWheelService()
    private init() {}

    let nextTick = PassthroughSubject<Void, Never>()
    let prevTick = PassthroughSubject<Void, Never>()
    let prevClick = PassthroughSubject<Void, Never>()
    let nextClick = PassthroughSubject<Void, Never>()
    let menuClick = PassthroughSubject<Void, Never>()
    let playPauseClick = PassthroughSubject<Void, Never>()
    let centerClick = PassthroughSubject<Void, Never>()

    func playTick() {
        SoundManager.shared.playTick()
    }

    func playTock() {
        SoundManager.shared.playTock()
    }
}

struct iPodClickWheel: View {
    @Binding var menuIndex: Int

    @State private var lastAngle: CGFloat = 0
    @State private var counter: CGFloat = 0
    @State private var menus = [1, 2, 3, 4, 5, 6, 7, 8]

    @GestureState private var centerClicked = false

    @Environment(\.colorScheme) private var colorScheme

    private var lightMode: Bool {
        colorScheme == .light
    }

    var body: some View {
        wheel
            .padding()
            .padding(.top, 24)
            .onChange(of: centerClicked) { clicked in
                if clicked {
                    Haptics.rigid()
                    ClickWheelService.shared.centerClick.send()
                } else {
                    Haptics.light()
                }
            }
    }

    private func frame(with proxy: GeometryProxy) -> CGSize {
        let sideLength = min(proxy.width, proxy.height)
        return .init(width: sideLength, height: sideLength)
    }

    private var wheel: some View {
        GeometryReader { proxy in
            VStack { // Wrapper to work around GeometryReader's .topLeading alignment rule
                Circle()
                    .fill(Color.systemBackground)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 0)
                    .overlay(
                        centerButton
                            .frame(width: proxy.width / 3.2, height: proxy.width / 3.2)
                    )
                    .overlay(ringItems)
                    .frame(frame(with: proxy))
                    .clipShape(Circle())
                    .gesture(rotationGesture(for: proxy.width))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }

    private var centerButton: some View {
        Circle()
            .gesture(centerClickGesture)
            .foregroundColor(lightMode ? Color.secondarySystemFill : Color.systemFill)
            .overlay(
                Circle()
                    .stroke(Color.primary.opacity(0.1), lineWidth: 0.5)
                    .shadow(color: Color.primary.opacity(0.8), radius: 10, x: 0, y: lightMode ? 4 : -4)
                    .if(centerClicked) {
                        $0.shadow(color: .primary, radius: 1, x: 0, y: 1)
                    }
                    .clipShape(Circle())
            )
            .overlay(
                centerButtonBorder
            )
    }

    private var centerButtonBorder: some View {
        Circle()
            .stroke(Color.clear, lineWidth: 2)
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
            .clipShape(
                Circle()
            )
    }

    private var ringItems: some View {
        VStack(spacing: 0) {
            Text("MENU")
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.bottom)
                .onTapGesture {
                    ClickWheelService.shared.menuClick.send()
                }
            Spacer()
            HStack {
                Image(systemName: "backward.end.alt.fill")
                    .padding(.vertical)
                    .padding(.trailing)
                    .onTapGesture {
                        ClickWheelService.shared.prevClick.send()
                    }

                Spacer()

                Image(systemName: "forward.end.alt.fill")
                    .padding(.vertical)
                    .padding(.leading)
                    .onTapGesture {
                        ClickWheelService.shared.nextClick.send()
                    }
            }
            Spacer()
            Image(systemName: "playpause.fill")
                .padding(.horizontal)
                .padding(.top)
                .onTapGesture {
                    ClickWheelService.shared.playPauseClick.send()
                }
        }
        .foregroundColor(lightMode ? .tertiaryLabel : Color.white.opacity(0.8))
        .font(.footnote)
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
    }

    private var centerClickGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .updating($centerClicked) { _, clicked, _ in
                clicked = true
            }
    }

    private func rotationGesture(for width: CGFloat, with sensitivity: Double = 40) -> some Gesture {
        DragGesture()
            .onChanged { v in
                // Calc rotation angle
                var angle = atan2(v.location.x - width * 0.9 / 2, width * 0.9 / 2 - v.location.y) * 180 / .pi
                if angle < 0 { angle += 360 }
                // Calc diff of rotation angle as theta
                let theta = self.lastAngle - angle
                self.lastAngle = angle
                // add theta
                if abs(theta) < CGFloat(sensitivity) {
                    self.counter += theta
                }
                // Move menu cursor when the counter become more(less) sensitivity.
                if self.counter > CGFloat(sensitivity) {
                    ClickWheelService.shared.prevTick.send()
                } else if self.counter < -CGFloat(sensitivity) {
                    ClickWheelService.shared.nextTick.send()
                }
                if abs(self.counter) > CGFloat(sensitivity) { self.counter = 0 }
            }
            .onEnded { _ in
                self.counter = 0
            }
    }
}
