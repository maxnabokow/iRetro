//
//  NowPlayingView.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/20/21.
//

import SwiftUI

struct NowPlayingView: View {
    @StateObject private var vm = NowPlayingViewModel()
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        Text(vm.nowPlayingItem?.title ?? "NO TITLE")
            .navigationBarHidden(true)
            .onAppear(perform: startNowPlayingSubscriptions)
            .onAppear(perform: startClickWheelSubscriptions)
            .onDisappear(perform: stopClickWheelSubscriptions)
    }

    private func startNowPlayingSubscriptions() {
        vm.startNowPlayingSubscriptions()
    }

    private func startClickWheelSubscriptions() {
        vm.startClickWheelSubscriptions(
            prevTick: nil,
            nextTick: nil,
            prevClick: nil,
            nextClick: nil,
            menuClick: { self.presentationMode.wrappedValue.dismiss() },
            playPauseClick: nil,
            centerClick: nil
        )
    }

    private func stopClickWheelSubscriptions() {
        vm.stopClickWheelSubscriptions()
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView()
    }
}
