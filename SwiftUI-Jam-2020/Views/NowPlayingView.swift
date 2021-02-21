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
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State var progress = 0.0
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                iPodStatusBar(title: "Now Playing")
                Spacer()

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
                    }
                }
                .padding(.leading)
                
                Spacer()
                
                HStack {
                    Text(formattedProgress)
                        .font(.caption2)
                    ProgressView(value: progress)
                        .scaleEffect(x: 1, y: 4, anchor: .center)
                        .onReceive(timer) { _ in updateProgress() }
                    Text(formattedTotalTime)
                        .font(.caption2)
                }
                .padding()
            }
        }
        .onAppear(perform: updateProgress)
    }
    
    private var formattedProgress: String {
        timeString(from: vm.currentTimeInSong)
    }

    private var formattedTotalTime: String {
        timeString(from: vm.totalTimeInSong)
    }
    
    private var timeProgress: Double {
        vm.currentTimeInSong / vm.totalTimeInSong
    }
    
    private func updateProgress() {
        progress = timeProgress
    }
    
    private func artwork(for proxy: GeometryProxy) -> some View {
        Image(uiImage: vm.artwork?.image(at: imageSize(for: proxy)) ?? UIImage(named: "abbeyRoad")!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(imageSize(for: proxy))
    }
    
    private func timeString(from time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60

        if hour == 0 { return String(format: "%i:%02i", minute, second) }
        else { return String(format: "%02i:%02i:%02i", hour, minute, second) }
    }
    
    private func imageSize(for proxy: GeometryProxy) -> CGSize {
        return CGSize(width: proxy.size.width / 4, height: proxy.size.width / 4)
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
