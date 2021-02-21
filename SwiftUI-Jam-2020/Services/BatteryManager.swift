//
//  BatteryManager.swift
//  SwiftUI-Jam-2020
//
//  Created by Andreas on 2/21/21.
//

import SwiftUI
import Combine

class BatteryManager {
    static let shared = BatteryManager()
    private init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    func getBatteryLevel() -> Float {
        let level = UIDevice.current.batteryLevel
        return level
    }
    func volumeChanged() -> AnyPublisher<Void, Never> {
        return UIDevice.current
            .publisher(for: \.batteryLevel)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
