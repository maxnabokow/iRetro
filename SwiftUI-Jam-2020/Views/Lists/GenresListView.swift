//
//  GenresListView.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/21/21.
//

import SwiftUI

struct GenresListView: View {
    @StateObject private var vm = GenresListViewModel()
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            StatusBar(title: "Genres")

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
        .onAppear(perform: startClickWheelSubscriptions)
        .onDisappear(perform: vm.stopClickWheelSubscriptions)
    }

    private func scroll(to index: Int, with proxy: ScrollViewProxy) {
        let id = vm.items[index].persistentID
        proxy.scrollTo(id)
    }

    private func row(at index: Int) -> some View {
        let item = vm.items[index]
        let selected = (vm.currentIndex == index)

        return
            HStack {
                Image(uiImage: item.representativeItem?.artworkImage() ?? UIImage(systemName: "sun.min")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)

                VStack(alignment: .leading) {
                    Text("GENRE")
                        .font(.caption)
                        .foregroundColor(selected ? .white : .secondary)
                    Text(item.representativeItem?.genre ?? "Genre")
                        .lineLimit(1)
                        .font(.headline)
                        .foregroundColor(selected ? .white : .primary)
                }

                Spacer(minLength: 0)
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .if(selected) {
                $0.background(
                    LinearGradient(gradient: Gradient(colors: [Color(.cyan), Color.blue.opacity(0.8)]), startPoint: .top, endPoint: .center)
                )
            }
            .id(item.persistentID)
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

struct GenresListView_Previews: PreviewProvider {
    static var previews: some View {
        GenresListView()
    }
}
