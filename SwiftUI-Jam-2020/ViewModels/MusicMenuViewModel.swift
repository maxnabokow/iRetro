//
//  MusicMenuViewModel.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import Combine
import SwiftUI

class MusicMenuViewModel: MenuViewModel, ObservableObject {
    let menuOptions = [
        MenuOption(title: "Cover Flow", destination: AnyView(Text("Cover Flow"))),
        MenuOption(title: "Playlists", destination: AnyView(Text("Playlists"))),
        MenuOption(title: "Artists", destination: AnyView(Text("Artists"))),
        MenuOption(title: "Albums", destination: AnyView(Text("Albums"))),
        MenuOption(title: "Compilations", destination: AnyView(Text("Compilations"))),
        MenuOption(title: "Songs", destination: AnyView(Text("Songs"))),
        MenuOption(title: "Genres", destination: AnyView(Text("Genres"))),
        MenuOption(title: "Composers", destination: AnyView(Text("Composers"))),
        MenuOption(title: "Audiobooks", destination: AnyView(Text("Audiobooks"))),
    ]

    @Published var currentIndex: Int = 0
    @Published internal var sinks = Set<AnyCancellable>()

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
    }

    func startClickWheelSubscriptions(
        prevTick: (() -> Void)? = nil,
        nextTick: (() -> Void)? = nil,
        prevClick: (() -> Void)? = nil,
        nextClick: (() -> Void)? = nil,
        menuClick: (() -> Void)? = nil,
        playPauseClick: (() -> Void)? = nil,
        center: (() -> Void)? = nil
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
                if let center = center {
                    center()
                }
            }
            .store(in: &sinks)
    }
}
