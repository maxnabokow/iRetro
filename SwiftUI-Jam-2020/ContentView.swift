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

    @State var fullView: Bool = false

    @State var zoomIn: Bool = false
    @Namespace private var namespace
    @Namespace private var externalNameSpace
    @Environment(\.colorScheme) private var colorScheme

    private var lightMode: Bool {
        colorScheme == .light
    }

    var body: some View {
        deviceView
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut) {
                        fullView = true
                    }
                }
            }
            .onTapGesture(count: 2) { zoomIn.toggle() }
    }

    private var deviceView: some View {
        Group {
            if zoomIn {
                VStack(spacing: 0) {
                    Display()
                        .matchedGeometryEffect(id: "display", in: namespace)
                    Clickwheel()
                        .matchedGeometryEffect(id: "clickwheel", in: namespace)
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                .background(lightMode ? Color.secondarySystemFill : Color.systemFill)
                .ignoresSafeArea()

            } else {
                if fullView {
                    VStack(spacing: 0) {
                        Spacer()
                        TabView(selection: $selectedDevice) {
                            DeviceView
                                .matchedGeometryEffect(id: "device", in: externalNameSpace)
                                .padding(24)
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }

                } else {
                    DeviceView
                        .matchedGeometryEffect(id: "device", in: externalNameSpace)
                        .padding(24)
                }
            }
        }
    }

    private var DeviceView: some View {
        GeometryReader { proxy in
            VStack { // Wrapper to work around GeometryReader's .topLeading alignment rule
                Classic(namespace: namespace, width: proxy.frame(in: .global).width)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
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
