//
//  CALayerView.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/06/23.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI

struct CALayerView: UIViewControllerRepresentable {
    var caLayer: CALayer
    let frame: CGRect
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CALayerView>) -> UIViewController {
        let viewController = UIViewController()
        
        viewController.view.layer.addSublayer(caLayer)
        caLayer.frame = frame
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CALayerView>) {
        caLayer.frame = frame
    }
}
