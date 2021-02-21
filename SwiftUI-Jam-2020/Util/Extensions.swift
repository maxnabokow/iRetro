//
//  Extensions.swift
//  Trove
//
//  Created by Max Nabokow on 6/2/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import CoreLocation
import MediaPlayer
import SwiftUI
import UIKit

extension MPMediaItem {
    func artworkImage(width: CGFloat = 100, height: CGFloat = 100) -> UIImage? {
        let size = CGSize(width: width, height: height)
        return self.artwork?.image(at: size)
    }
}

enum MyNotifications: String {
    case showFullScreenView
}

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
