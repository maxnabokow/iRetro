//
//  NonDismissableSheet.swift
//  Trove
//
//  Created by Max Nabokow on 12/18/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import SwiftUI

struct NonDismissibleSheetFiller: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<NonDismissibleSheetFiller>) -> UIViewController {
        NonDismissibleViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension NonDismissibleSheetFiller {
    private final class NonDismissibleViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
        override func didMove(toParent parent: UIViewController?) {
            super.didMove(toParent: parent)
            
            setup()
        }
        
        func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
            return false
        }
        
        private func setup() {
            guard
                let rootPresentationViewController = rootParent.presentationController, rootPresentationViewController.delegate == nil
            else { return }
            
            rootPresentationViewController.delegate = self
        }
    }
}

private extension UIViewController {
    var rootParent: UIViewController {
        if let parent = self.parent {
            return parent.rootParent
        } else {
            return self
        }
    }
}

extension View {
    func nonDismissibleInSheet() -> some View {
        background(NonDismissibleSheetFiller())
    }
}
