//
//  SongsListView.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/20/21.
//

import MediaPlayer
import SwiftUI

struct SongsListView: View {
    @StateObject private var vm = SongsListViewModel()
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            StatusBar(title: "Songs")

            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(0 ..< vm.items.count, id: \.self) { i in
                            row(at: i)
                            Divider()
                        }
                    }
                    .onChange(of: vm.currentIndex) { index in
                        scroll(to: index, with: proxy)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .disabled(true)
        .onAppear(perform: startClickWheelSubscriptions)
        .onDisappear(perform: vm.stopClickWheelSubscriptions)
    }

    private func scroll(to index: Int, with proxy: ScrollViewProxy) {
        let id = vm.items[index].playbackStoreID
        proxy.scrollTo(id)
    }

    private func row(at index: Int) -> some View {
        let item = vm.items[index]
        let selected = (vm.currentIndex == index)

        return
            HStack(spacing: 0) {
                Image(uiImage: item.artworkImage() ?? UIImage(systemName: "music.note")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)

                VStack(alignment: .leading) {
                    Text(item.title ?? "NO TITLE")
                        .lineLimit(1)
                        .font(.headline)
                        .foregroundColor(selected ? .white : .primary)
                    Text(item.artist ?? "NO ARTIST")
                        .lineLimit(1)
                        .foregroundColor(selected ? .white : .secondary)
                }
                .padding(.horizontal)

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .if(selected) {
                $0.background(
                    LinearGradient(gradient: Gradient(colors: [Color(.cyan), Color.blue.opacity(0.8)]), startPoint: .top, endPoint: .center)
                )
            }
            .id(item.playbackStoreID)
    }

    private func startClickWheelSubscriptions() {
        vm.startClickWheelSubscriptions(
            prevTick: nil,
            nextTick: nil,
            prevClick: { presentationMode.wrappedValue.dismiss() },
            nextClick: nil,
            menuClick: { presentationMode.wrappedValue.dismiss() },
            playPauseClick: nil,
            centerClick: nil
        )
    }
}

struct SongsListView_Previews: PreviewProvider {
    static var previews: some View {
        SongsListView()
    }
}
