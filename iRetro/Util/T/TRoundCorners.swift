//
//  TRoundCorners.swift
//  Trove
//
//  Created by Max Nabokow on 12/30/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import SwiftUI

struct CustomRoundedRectangle: Shape {
    var radius: CGFloat
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func tRoundCorners(_ radius: CGFloat = 12, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(
            CustomRoundedRectangle(
                radius: radius,
                corners: corners
            )
        )
    }
}
