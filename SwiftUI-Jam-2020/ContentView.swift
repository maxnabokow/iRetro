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
    #warning("Fix match geo, tabs")
    @Namespace private var nameSpace
    @Namespace private var externalNameSpace
    @Environment(\.colorScheme) private var colorScheme
    
    private var lightMode: Bool {
        colorScheme == .light
    }

    var body: some View {
       
        Group {
        if zoomIn {
            ZStack {
                Group {
                lightMode ? Color.secondarySystemFill : Color.systemFill
                } .ignoresSafeArea()
            VStack(spacing: 0) {
            iPodDisplay()
                iPodClickWheel()
            bottomBar
                .padding(.horizontal)
            } .padding()
            }
           
        } else {
        if fullView {
            VStack(spacing: 0) {
                Spacer()
                TabView(selection: $selectedDevice) {
                   
                        iPodView
                            .matchedGeometryEffect(id: "iPod", in: externalNameSpace)
                            .padding(24)
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                Spacer()

                bottomBar
                    .padding(.horizontal)
                    .transition(.move(edge: .bottom))
                   
            }
          
        } else {
            iPodView
                .matchedGeometryEffect(id: "iPod", in: externalNameSpace)
                .padding(24)
                
        }
        }
         
    } .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut) {
            fullView = true
            }
        }
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
            Button { withAnimation() {zoomIn.toggle()} } label: {
                Image(systemName: "magnifyingglass")
                    .padding()
                    .background(Color.secondarySystemBackground)
                    .clipShape(Circle())
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
