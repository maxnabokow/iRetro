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
    func batteryChanged() -> AnyPublisher<Double, Never> {
        return UIDevice.current
            .publisher(for: \.batteryLevel)
            .map { Double( $0) }
            .eraseToAnyPublisher()
    }
}
