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
                    artwork(for: proxy)
                    VStack {
                        HStack {
                            Text(vm.nowPlayingItem?.title ?? "NO TITLE")
                                .font(.footnote)
                                .bold()
                                .navigationBarHidden(true)
                                .onAppear(perform: startNowPlayingSubscriptions)
                                .onAppear(perform: startClickWheelSubscriptions)
                                .onDisappear(perform: stopClickWheelSubscriptions)
                            Spacer()
                        }
                        HStack {
                            Text(vm.nowPlayingItem?.artist ?? "NO ARTIST")
                                .navigationBarHidden(true)
                                .font(.footnote)
                            Spacer()
                        }
                        
                    }.padding(3)
                }
                Spacer()
                ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                    .accentColor(.blue)
                    .padding()
            }
        }
    }
    
    private func artwork(for proxy: GeometryProxy) -> some View {
        Image(uiImage: vm.artwork?.image(at: imageSize(for: proxy)) ?? UIImage(named: "abbeyRoad")!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(imageSize(for: proxy))
    }
    
    private func imageSize(for proxy: GeometryProxy) -> CGSize {
        return CGSize(width: proxy.size.width/4, height: proxy.size.width/4)
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
