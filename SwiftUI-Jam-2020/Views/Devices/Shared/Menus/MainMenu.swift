//
//  iPodMenu.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import SwiftUI

struct MainMenu: View {
    @StateObject private var vm = MainMenuViewModel()

    var body: some View {
        NavigationView {
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
}
