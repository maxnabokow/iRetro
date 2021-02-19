//
//  TextField+ClearButton.swift
//  Trove
//
//  Created by Max Nabokow on 12/24/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import SwiftUIX

public extension TextField {
    func withClearButton(for text: Binding<String>, with size: Font? = .callout) -> some View {
        self
            .modifier(TextFieldClearButton(text: text, size: size))
    }
}

public extension CocoaTextField {
    func withClearButton(for text: Binding<String>, with size: Font? = .callout) -> some View {
        self
            .modifier(TextFieldClearButton(text: text, size: size))
    }
}

private struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    let size: Font?

    public func body(content: Content) -> some View {
        HStack {
            content
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "multiply.circle.fill")
                    .font(self.size)
                    .foregroundColor(.secondary)
            }
        }
    }
}
