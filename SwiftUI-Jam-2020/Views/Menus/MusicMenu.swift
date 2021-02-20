//
//  MusicMenu.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import SwiftUI

struct MusicMenu: View {
    @StateObject private var vm = MusicMenuViewModel()
    @Environment(\.presentationMode) private var presentationMode
    @State private var childrenShowing = Array(repeating: false, count: 12) // dangerous, yes.

    init() {
        childrenShowing = Array(repeating: false, count: vm.menuOptions.count)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0 ..< vm.menuOptions.count, id: \.self) { i in
                NavigationLink(destination: vm.destination(at: i), isActive: $childrenShowing[i], label: {
                    vm.row(at: i)
                })
            }
            Spacer()
        }
        .font(.headline)
        .navigationBarHidden(true)
        .onAppear(perform: startClickWheelSubscriptions)
        .onDisappear(perform: stopClickWheelSubscriptions)
    }

    private func startClickWheelSubscriptions() {
        vm.startClickWheelSubscriptions(
            prevTick: nil,
            nextTick: nil,
            prevClick: { presentationMode.wrappedValue.dismiss() },
            nextClick: { childrenShowing[vm.currentIndex] = true },
            menuClick: { presentationMode.wrappedValue.dismiss() },
            playPauseClick: nil,
            centerClick: { childrenShowing[vm.currentIndex] = true })
    }

    private func stopClickWheelSubscriptions() {
        vm.stopClickWheelSubscriptions()
    }
}
