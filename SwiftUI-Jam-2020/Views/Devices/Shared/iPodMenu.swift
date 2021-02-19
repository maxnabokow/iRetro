//
//  iPodMenu.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import SwiftUI

struct iPodMenu: View {
    @Binding var menuIndex: Int
    let menuOptions = [
        "Music", "Videos", "Photos", "Podcasts", "Extras", "Settings", "Shuffle Songs", "Now Playing"
    ]

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0 ..< menuOptions.count, id: \.self) { i in
                    if i == menuIndex {
                        selectedMenuRow(for: menuOptions[i])
                    } else {
                        Text(menuOptions[i])
                            .padding(.vertical, 3)
                            .padding(.horizontal, 6)
                    }
                }
                Spacer()
            }
            .font(.headline)
        }
    }

    private func selectedMenuRow(for menuOption: String) -> some View {
        HStack {
            Text(menuOption)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundColor(.white)
        .padding(.vertical, 3)
        .padding(.horizontal, 6)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(.cyan), Color.blue.opacity(0.8)]), startPoint: .top, endPoint: .center)
        )
    }
}
