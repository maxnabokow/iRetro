//
//  MusicMenu.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import SwiftUI

struct MusicMenu: View {
    @StateObject private var vm = MusicMenuViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0 ..< vm.menuOptions.count, id: \.self) { i in
                NavigationLink(destination: vm.destination(at: i), label: {
                    vm.row(at: i)
                })
            }
            Spacer()
        }
        .font(.headline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: vm.startClickWheelSubscriptions)
        .onDisappear(perform: vm.stopClickWheelSubscriptions)
    }
}
