//
//  UserData.swift
//  SwiftUI-Jam-2020
//
//  Created by Andreas on 2/21/21.
//

import SwiftUI

final class UserData: ObservableObject {
    static let shared = UserData()
    private init() {}

    @AppStorage("firstRun") var firstRun: Bool = true
    @AppStorage("isOnboardingCompleted") var isOnboardingCompleted: Bool = false
}
