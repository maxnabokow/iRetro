//
//  DisplayViewModel.swift
//  iRetro
//
//  Created by Max Nabokow on 2/20/21.
//

import Combine
import SwiftUI
import MediaPlayer
class DisplayViewModel: ObservableObject {
    @Published var nowPlayingItem: MPMediaItem?
    @Published var showFullScreen: Bool = false {
        didSet {
            if !showFullScreen {
                resetFullScreenView()
            }
        }
    }
    var artwork: MPMediaItemArtwork? {
        return nowPlayingItem?.artwork
    }
    
    var fullScreenView = AnyView(EmptyView())

    var sinks = Set<AnyCancellable>()

    private func resetFullScreenView() {
        fullScreenView = AnyView(EmptyView())
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
    func startListeningToFullScreenNotifications() {
        NotificationCenter.default.publisher(for: .init(MyNotifications.showFullScreenView.rawValue))
            .sink { notification in
                if let view = notification.userInfo?["view"] as? AnyView {
                    self.fullScreenView = view
                    self.showFullScreen = true
                }
            }
            .store(in: &sinks)
    }
}
