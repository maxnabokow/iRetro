//
//  MainMenuViewModel.swift
//  iRetro
//
//  Created by Max Nabokow on 2/19/21.
//

import Combine
import MediaPlayer
import SwiftUI

class MainMenuViewModel: MenuViewModel, ObservableObject {
    lazy var menuOptions = [
        MenuOption(title: "Music", nextMenu: AnyView(MusicMenu())),
        MenuOption(title: "Videos", nextMenu: nil),
        MenuOption(title: "Photos", nextMenu: nil),
        MenuOption(title: "Podcasts", nextMenu: nil),
        MenuOption(title: "Extras", nextMenu: nil),
        MenuOption(title: "Settings", nextMenu: nil),
        MenuOption(title: "Shuffle Songs", nextMenu: nil,
                   withDisclosure: false, onSelect: shuffleAndPlay),
    ]

    @Published var currentIndex: Int = 0

    var playState: MPMusicPlaybackState = MusicManager.shared.playState
    var showsNowPlayingMenuOption = false

    var sinks = Set<AnyCancellable>()

    func startPlayStateSubscriptions() {
        playState = MusicManager.shared.playState
        if playState == .playing { addNowPlayingMenuOption() }

        MusicManager.shared.playStateChanged()
            .sink { state in
                let previous = self.playState

                if state == .stopped {
                    self.removeNowPlayingMenuOption()
                } else if previous == .stopped {
                    self.addNowPlayingMenuOption()
                }
                self.playState = state
            }
            .store(in: &sinks)
    }

    func shuffleAndPlay() {
        MusicManager.shared.playShuffledSongs()
        showNowPlayingView()
    }

    func showNowPlayingView() {
        let dict: [String: AnyView] = ["view": AnyView(NowPlayingView())]
        let name = MyNotifications.showFullScreenView.rawValue
        let notification = Notification(name: .init(name), userInfo: dict)
        NotificationCenter.default.post(notification)
    }

    func addNowPlayingMenuOption() {
        if !showsNowPlayingMenuOption {
            menuOptions.append(
                MenuOption(title: "Now Playing", nextMenu: nil, onSelect: showNowPlayingView)
            )
            showsNowPlayingMenuOption = true
        }
        objectWillChange.send()
    }

    func removeNowPlayingMenuOption() {
        if menuOptions.last?.title == "Now Playing" {
            menuOptions.removeLast()
            showsNowPlayingMenuOption = false
            objectWillChange.send()
        }
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

        ClickWheelService.shared.menuClick
            .receive(on: RunLoop.main)
            .sink {
                self.menuClick()
                if let click = menuClick {
                    click()
                }
            }
            .store(in: &sinks)

        ClickWheelService.shared.playPauseClick
            .receive(on: RunLoop.main)
            .sink {
                self.playPauseClick()
                if let click = playPauseClick {
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
