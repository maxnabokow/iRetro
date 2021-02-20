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
        MenuOption(title: "Songs", destination: AnyView(Text("Songs"))),
        MenuOption(title: "Playlists", destination: AnyView(Text("Playlists"))),
        MenuOption(title: "Albums", destination: AnyView(Text("Albums"))),
        MenuOption(title: "Artists", destination: AnyView(Text("Artists"))),
        MenuOption(title: "Genres", destination: AnyView(Text("Genres"))),
    ]

    @Published var currentIndex: Int = 0
    @Published internal var sinks = Set<AnyCancellable>()

    func prev() {
        if currentIndex != 0 {
            currentIndex -= 1
            ClickWheelService.shared.playTick()
        }
    }

    func next() {
        if currentIndex != menuOptions.count - 1 {
            currentIndex += 1
            ClickWheelService.shared.playTick()
        }
    }

    func startClickWheelSubscriptions() {
        ClickWheelService.shared.prevTick
            .receive(on: RunLoop.main)
            .sink(receiveValue: prev)
            .store(in: &sinks)

        ClickWheelService.shared.nextTick
            .receive(on: RunLoop.main)
            .sink(receiveValue: next)
            .store(in: &sinks)
    }
}
