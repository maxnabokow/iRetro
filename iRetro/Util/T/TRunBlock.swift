//
//  RunBlock.swift
//  Trove
//
//  Created by Max Nabokow on 12/30/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import SwiftUI

struct Run: View {
    let block: () -> Void

    var body: some View {
        DispatchQueue.main.async(execute: block)
        return AnyView(EmptyView())
    }
}
