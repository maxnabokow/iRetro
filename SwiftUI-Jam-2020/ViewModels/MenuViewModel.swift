//
//  MenuViewModel.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import Combine
import SwiftUI

protocol MenuViewModel {
    var menuOptions: [MenuOption<AnyView>] { get }
    var currentIndex: Int { get set }
    var sinks: Set<AnyCancellable> { get set }
}

extension MenuViewModel {
    func row(at index: Int) -> some View {
        if index == currentIndex {
            let option = menuOptions[index]
            return AnyView(selectedMenuRow(for: option.title, withDisclosure: option.withDisclosure))
        } else {
            return
                AnyView(Text(menuOptions[index].title)
                        .foregroundColor(.primary)
                        .padding(.vertical, 3)
                        .padding(.horizontal, 6))
        }
    }

    private func selectedMenuRow(for title: String, withDisclosure: Bool) -> some View {
        HStack {
            Text(title)
            Spacer()
            if withDisclosure {
                Image(systemName: "chevron.right")
            }
        }
        .foregroundColor(.white)
        .padding(.vertical, 3)
        .padding(.horizontal, 6)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(.cyan), Color.blue.opacity(0.8)]), startPoint: .top, endPoint: .center)
        )
    }

    func destination(at i: Int) -> some View {
        guard let option = menuOptions[safe: i] else { fatalError() }
        return option.destination
    }

    func stopClickWheelSubscriptions() {
        sinks.forEach { cancellable in
            cancellable.cancel()
        }
    }
}

struct MenuOption<Content: View> {
    let title: String
    let destination: Content
    var withDisclosure: Bool = true
}
