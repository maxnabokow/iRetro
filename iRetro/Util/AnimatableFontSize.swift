//
//  AnimatableFontSize.swift
//  Trove
//
//  Created by Max Nabokow on 12/21/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import SwiftUI

struct AnimatableSystemFontModifier: AnimatableModifier {
    var style: Font

    var animatableData: Font {
        get { style }
        set { style = newValue }
    }

    func body(content: Content) -> some View {
        content
            .font(style)
    }
}

extension View {
    func animatableSystemFont(_ style: Font) -> some View {
        modifier(AnimatableSystemFontModifier(style: style))
    }
}
