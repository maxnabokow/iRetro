//
//  PlayShape.swift
//  iRetro
//
//  Created by Max Nabokow on 2/19/21.
//

import SwiftUI

struct PauseShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: .init(x: rect.minX, y: rect.minY))
        path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        path.addLine(to: .init(x: rect.maxX / 3, y: rect.maxY))
        path.addLine(to: .init(x: rect.maxX / 3, y: rect.minY))

        path.move(to: .init(x: 2*rect.maxX / 3, y: rect.minY))
        path.move(to: .init(x: 2*rect.maxX / 3, y: rect.maxY))
        path.move(to: .init(x: rect.maxX, y: rect.maxY))
        path.move(to: .init(x: rect.maxX, y: rect.minY))

        return path
    }
}

struct PlayShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: .init(x: rect.minX, y: rect.minY))
        path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        path.addLine(to: .init(x: rect.maxX, y: rect.height / 2))
        path.closeSubpath()

        return path
    }
}

struct PlayShape_Previews: PreviewProvider {
    static var previews: some View {
        PlayShape()
    }
}
