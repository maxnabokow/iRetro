//
//  HapticFeedback.swift
//  Trove
//
//  Created by Max Nabokow on 5/22/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import SwiftUI

class Haptics {
    private static let notificationGenerator = UINotificationFeedbackGenerator()
    private static let impactLight = UIImpactFeedbackGenerator(style: .light)
    private static let impactMedium = UIImpactFeedbackGenerator(style: .medium)
    private static let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
    private static let impactSoft = UIImpactFeedbackGenerator(style: .soft)
    private static let impactRigid = UIImpactFeedbackGenerator(style: .rigid)
    private static let selectionGenerator = UISelectionFeedbackGenerator()

    private static let defaultDebounceInterval = 0.2

    static func light(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                impactLight.impactOccurred()
            }
        } else {
            impactLight.impactOccurred()
        }
    }

    static func medium(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                impactMedium.impactOccurred()
            }
        } else {
            impactMedium.impactOccurred()
        }
    }

    static func heavy(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                impactHeavy.impactOccurred()
            }
        } else {
            impactHeavy.impactOccurred()
        }
    }

    static func soft(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                impactSoft.impactOccurred()
            }
        } else {
            impactSoft.impactOccurred()
        }
    }

    static func rigid(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                impactRigid.impactOccurred()
            }
        } else {
            impactRigid.impactOccurred()
        }
    }

    static func success(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                notificationGenerator.notificationOccurred(.success)
            }
        } else {
            notificationGenerator.notificationOccurred(.success)
        }
    }

    static func warning(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                notificationGenerator.notificationOccurred(.warning)
            }
        } else {
            notificationGenerator.notificationOccurred(.warning)
        }
    }

    static func error(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                notificationGenerator.notificationOccurred(.error)
            }
        } else {
            notificationGenerator.notificationOccurred(.error)
        }
    }

    static func selected(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                selectionGenerator.selectionChanged()
            }
        } else {
            selectionGenerator.selectionChanged()
        }
    }
}

public extension DispatchQueue {
    func debounced(target: AnyObject, after delay: TimeInterval, perform: @escaping @convention(block) () -> Void) {
        let debounceId = DispatchQueue.debounceIdFor(target)
        if let existingWorkItem = DispatchQueue.workItems.removeValue(forKey: debounceId) {
            existingWorkItem.cancel()
        }
        let workItem = DispatchWorkItem {
            DispatchQueue.workItems.removeValue(forKey: debounceId)

            for ptr in DispatchQueue.weakTargets.allObjects {
                if debounceId == DispatchQueue.debounceIdFor(ptr as AnyObject) {
                    perform()
                    break
                }
            }
        }

        DispatchQueue.workItems[debounceId] = workItem
        DispatchQueue.weakTargets.addPointer(Unmanaged.passUnretained(target).toOpaque())

        asyncAfter(deadline: .now() + delay, execute: workItem)
    }
}

// MARK: - Static Properties for De-Duping

private extension DispatchQueue {
    static var workItems = [AnyHashable: DispatchWorkItem]()
    static var weakTargets = NSPointerArray.weakObjects()

    static func debounceIdFor(_ object: AnyObject) -> String {
        return "\(Unmanaged.passUnretained(object).toOpaque())." + String(describing: object)
    }
}
