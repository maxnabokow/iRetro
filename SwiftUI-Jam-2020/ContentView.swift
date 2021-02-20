//
//  ContentView.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import SwiftUI

struct ContentView: View {
    static let screenDimensions = UIScreen.main.bounds
    let width = screenDimensions.width - 48
    @State private var selectedDevice: Int = 0

    let fullView: Bool = false

    var body: some View {
        if fullView {
            VStack(spacing: 0) {
                Spacer()
                TabView(selection: $selectedDevice) {
                    ForEach(0 ..< 1) { _ in
                        iPodView
                            .padding(24)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                Spacer()

                bottomBar
                    .padding(.horizontal)
            }
        } else {
            iPodView
                .padding(24)
        }
    }

    private var iPodView: some View {
        GeometryReader { proxy in
            VStack { // Wrapper to work around GeometryReader's .topLeading alignment rule
                iPodClassic()
                    .frame(width: proxy.frame(in: .global).width, height: 1.8 * proxy.frame(in: .global).width)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }

    private var bottomBar: some View {
        HStack {
            Button { print("Left") } label: {
                Image(systemName: "chevron.left")
                    .padding()
                    .background(Color.secondarySystemBackground)
                    .clipShape(Circle())
            }
            Spacer()
            Button { MusicManager.shared.previous() } label: {
                Text("Select")
                    .fontWeight(.semibold)
                    .padding()
                    .padding(.horizontal, 24)
                    .background(Color.secondarySystemBackground)
                    .clipShape(Capsule())
            }
            Spacer()
            Button { print("Right") } label: {
                Image(systemName: "chevron.right")
                    .padding()
                    .background(Color.secondarySystemBackground)
                    .clipShape(Circle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
