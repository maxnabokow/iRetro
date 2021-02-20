//
//  Extensions.swift
//  Trove
//
//  Created by Max Nabokow on 6/2/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import CoreLocation
import SwiftUI
import UIKit

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension GeometryProxy {
    var height: CGFloat {
        return self.frame(in: .global).height
    }

    var width: CGFloat {
        return self.frame(in: .global).width
    }

    var minY: CGFloat {
        return self.frame(in: .global).minY
    }
    
}
let screenDemensions = UIScreen.main.bounds
