//
//  SoundManager.swift
//  SwiftUI-Jam-2020
//
//  Created by Max Nabokow on 2/19/21.
//

import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    private init() {}

    func playTick() {
        var soundID: SystemSoundID = 0
        let fileURL = URL(fileURLWithPath: "/System/Library/Audio/UISounds/nano/TimerWheelMinutesDetent_Haptic.caf") as CFURL
        AudioServicesCreateSystemSoundID(fileURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }

    func playTock() {
        AudioServicesPlaySystemSound(1104)
    }
}
