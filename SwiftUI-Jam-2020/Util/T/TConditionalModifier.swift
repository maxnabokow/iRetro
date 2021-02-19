//
//  View+if.swift
//  Trove
//
//  Created by Max Nabokow on 12/21/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}
