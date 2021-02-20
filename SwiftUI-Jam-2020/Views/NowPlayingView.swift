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
        GeometryReader { proxy in
            VStack {
                iPodStatusBar()
        HStack {
            Image(uiImage: vm.nowPlayingItem?.artwork?.image(at: CGSize(width: proxy.size.width/4, height: proxy.size.width/4)) ?? UIImage(named: "abbeyRoad")!)
                
               
                .scaledToFit()
        Text(vm.nowPlayingItem?.title ?? "NO TITLE")
            .navigationBarHidden(true)
            .onAppear(perform: startNowPlayingSubscriptions)
            .onAppear(perform: startClickWheelSubscriptions)
            .onDisappear(perform: stopClickWheelSubscriptions)
            .padding()
        }
                

            }
    }
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
