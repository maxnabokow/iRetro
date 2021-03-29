//
//  NowPlayingView.swift
//  iRetro
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
            VStack(spacing: 0) {
                StatusBar(title: "Now Playing")
                
                VStack(alignment: .leading) {
                    HStack {
                        artwork(for: proxy)
                            .overlay(
                                artwork(for: proxy, withHeightFactor: 0.3)
                                    .overlay(
                                        LinearGradient(gradient: .init(colors: [.clear, .systemBackground]), startPoint: .bottom, endPoint: .top)
                                    )
                                    .rotation3DEffect(.degrees(180 + 70), axis: (x: 1.0, y: 0, z: 0), anchor: .bottomLeading)
                                    .opacity(0.3),
                                alignment: .bottom
                            )
                            .rotation3DEffect(.degrees(7), axis: (x: 0, y: 1.0, z: 0))
                        VStack(alignment: .leading) {
                            Text(vm.nowPlayingItem?.title ?? "NO TITLE")
                                .font(.footnote)
                                .bold()
                                .navigationBarHidden(true)
                                .onAppear(perform: startNowPlayingSubscriptions)
                                .onAppear(perform: startClickWheelSubscriptions)
                                .onDisappear(perform: stopClickWheelSubscriptions)
                            Text(vm.nowPlayingItem?.artist ?? "NO ARTIST")
                                .navigationBarHidden(true)
                                .font(.footnote)
                        }
                    }
                
                    Spacer()
                
                    HStack {
                        Text(formattedProgress)
                            .font(.system(.caption2, design: .monospaced))
                        ProgressView(value: progress)
                            .scaleEffect(x: 1, y: 4, anchor: .center)
                            .onReceive(timer) { _ in updateProgress() }
                        Text(formattedRemainingTime)
                            .font(.system(.caption2, design: .monospaced))
                    }
                }
                .padding()
            }
        }
    }
    
    private var formattedProgress: String {
        timeString(from: vm.currentTimeInSong)
    }

    private var formattedRemainingTime: String {
        let timeRemaining = vm.totalTimeInSong - vm.currentTimeInSong
        return "-\(timeString(from: timeRemaining))"
    }
    
    private var timeProgress: Double {
        vm.currentTimeInSong / vm.totalTimeInSong
    }
    
    private func updateProgress() {
        progress = timeProgress
    }
    
    private func artwork(for proxy: GeometryProxy, withHeightFactor heightFactor: CGFloat = 1) -> some View {
        Image(uiImage: vm.artwork?.image(at: imageSize(for: proxy, withHeightFactor: heightFactor)) ?? UIImage(named: "abbeyRoad")!)
            .resizable()
            .if(heightFactor == 1) {
                $0.aspectRatio(contentMode: .fill)
            }
            .frame(imageSize(for: proxy, withHeightFactor: heightFactor))
    }

    private func imageSize(for proxy: GeometryProxy, withHeightFactor heightFactor: CGFloat) -> CGSize {
        let sideLength = proxy.size.width / 2.3
        return CGSize(width: sideLength, height: sideLength * heightFactor)
    }
    
    private func timeString(from time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60

        if hour == 0 { return String(format: "%i:%02i", minute, second) }
        else { return String(format: "%02i:%02i:%02i", hour, minute, second) }
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
