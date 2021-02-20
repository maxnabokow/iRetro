//
//  MainMenuViewModel.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import Combine
import SwiftUI

class MainMenuViewModel: MenuViewModel, ObservableObject {
    lazy var menuOptions = [
        MenuOption(title: "Music", destination: AnyView(MusicMenu())),
        MenuOption(title: "Videos", destination: AnyView(Text("Hi"))),
        MenuOption(title: "Photos", destination: AnyView(Text("Hi"))),
        MenuOption(title: "Podcasts", destination: AnyView(Text("Hi"))),
        MenuOption(title: "Extras", destination: AnyView(Text("Hi"))),
        MenuOption(title: "Settings", destination: AnyView(Text("Hi"))),
        MenuOption(title: "Shuffle Songs", destination: nil,
                   withDisclosure: false, onSelect: shuffleAndPlay),
        MenuOption(title: "Now Playing", destination: AnyView(Text("Hi"))),
    ]

    @Published var currentIndex: Int = 0
    @Published internal var sinks = Set<AnyCancellable>()

    func shuffleAndPlay() {
        MusicManager.shared.playShuffledSongs()
        let dict: [String: AnyView] = ["view": AnyView(Color.red)]
        let notification = Notification(name: .init("showFullScreenView"), userInfo: dict)
        NotificationCenter.default.post(notification)
    }

    // MARK: - Wheel clicks

    func prevTick() {
        if currentIndex != 0 {
            currentIndex -= 1
            ClickWheelService.shared.playTick()
        }
    }

    func nextTick() {
        if currentIndex != menuOptions.count - 1 {
            currentIndex += 1
            ClickWheelService.shared.playTick()
        }
    }

    func prevClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
    }

    func nextClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
    }

    func menuClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
    }

    func playPauseClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
    }

    func centerClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()

        if let onSelect = menuOptions[currentIndex].onSelect {
            onSelect()
        }
    }

    func startClickWheelSubscriptions(
        prevTick: (() -> Void)? = nil,
        nextTick: (() -> Void)? = nil,
        prevClick: (() -> Void)? = nil,
        nextClick: (() -> Void)? = nil,
        menuClick: (() -> Void)? = nil,
        playPauseClick: (() -> Void)? = nil,
        centerClick: (() -> Void)? = nil
    ) {
        ClickWheelService.shared.prevTick
            .receive(on: RunLoop.main)
            .sink {
                self.prevTick()
                if let tick = prevTick {
                    tick()
                }
            }
            .store(in: &sinks)

        ClickWheelService.shared.nextTick
            .receive(on: RunLoop.main)
            .sink {
                self.nextTick()
                if let tick = nextTick {
                    tick()
                }
            }
            .store(in: &sinks)

        ClickWheelService.shared.prevClick
            .receive(on: RunLoop.main)
            .sink {
                self.prevClick()
                if let click = prevClick {
                    click()
                }
            }
            .store(in: &sinks)

        ClickWheelService.shared.nextClick
            .receive(on: RunLoop.main)
            .sink {
                self.nextClick()
                if let click = nextClick {
                    click()
                }
            }
            .store(in: &sinks)

        ClickWheelService.shared.centerClick
            .receive(on: RunLoop.main)
            .sink {
                self.centerClick()
                if let center = centerClick {
                    center()
                }
            }
            .store(in: &sinks)
    }
}
