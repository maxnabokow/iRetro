//
//  BlurView.swift
//  Trove
//
//  Created by Max Nabokow on 7/4/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    typealias UIViewType = UIView
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        view.insertSubview(blurView, at: 0)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {}
}
