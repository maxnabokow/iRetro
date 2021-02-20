//
//  MainMenuViewModel.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import Combine
import SwiftUI

class MainMenuViewModel: MenuViewModel, ObservableObject {
    let menuOptions = [
        MenuOption(title: "Music", destination: AnyView(MusicMenu())),
        MenuOption(title: "Videos", destination: AnyView(Text("Hi"))),
        MenuOption(title: "Photos", destination: AnyView(Text("Hi"))),
        MenuOption(title: "Podcasts", destination: AnyView(Text("Hi"))),
        MenuOption(title: "Extras", destination: AnyView(Text("Hi"))),
        MenuOption(title: "Settings", destination: AnyView(Text("Hi"))),
        MenuOption(title: "Shuffle Songs", destination: AnyView(Text("Hi"))),
        MenuOption(title: "Now Playing", destination: AnyView(Text("Hi"))),
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
