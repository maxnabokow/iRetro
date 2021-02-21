//
//  DisplayViewModel.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/20/21.
//

import Combine
import SwiftUI

class DisplayViewModel: ObservableObject {
    @Published var showFullScreen: Bool = false {
        didSet {
            if !showFullScreen {
                resetFullScreenView()
            }
        }
    }

    var fullScreenView = AnyView(EmptyView())

    var sinks = Set<AnyCancellable>()

    private func resetFullScreenView() {
        fullScreenView = AnyView(EmptyView())
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
