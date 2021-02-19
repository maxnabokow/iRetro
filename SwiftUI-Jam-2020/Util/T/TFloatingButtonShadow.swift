//
//  TFloatingButtonShadow.swift
//  Trove
//
//  Created by Max Nabokow on 12/30/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import SwiftUI

extension View {
    func tFloatingButtonShadow() -> some View {
        return self
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
    }
}
