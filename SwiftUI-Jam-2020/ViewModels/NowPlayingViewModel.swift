//
//  NowPlayingViewModel.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/20/21.
//

import Combine
import MediaPlayer
import SwiftUI

class NowPlayingViewModel: ObservableObject {
    @Published var nowPlayingItem: MPMediaItem? // not sure, might be bad

    private var sinks = Set<AnyCancellable>()

    var artwork: MPMediaItemArtwork? {
        return nowPlayingItem?.artwork
    }

    func startNowPlayingSubscriptions() {
        nowPlayingItem = MusicManager.shared.nowPlayingItem

        MusicManager.shared.nowPlayingChanged()
            .print()
            .sink {
                self.nowPlayingItem = MusicManager.shared.nowPlayingItem
            }
            .store(in: &sinks)
    }

    // MARK: - Wheel clicks

    func prevTick() {}

    func nextTick() {}

    func prevClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
        MusicManager.shared.previous()
    }

    func nextClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
        MusicManager.shared.next()
    }

    func menuClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
    }

    func playPauseClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
        MusicManager.shared.playPause()
    }

    func centerClick() {
        Haptics.rigid()
        ClickWheelService.shared.playTock()
        MusicManager.shared.stop()
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

    func stopClickWheelSubscriptions() {
        sinks.forEach { cancellable in
            cancellable.cancel()
        }
    }
}
