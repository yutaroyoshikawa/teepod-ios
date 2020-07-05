//
//  CheckPresenter.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

final class CheckPresenter: ObservableObject {
    private let router = CheckRouter()
    private let interactor = CheckInteractor()
    
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var previewLayer: CALayer {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var image: UIImage? {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        previewLayer = interactor.setupAVCaptureSession()
    }
    
    func onCaptureOutput(outputImage: UIImage) {
        DispatchQueue.main.async {
            self.image = outputImage
        }
    }
    
    func updateImage(newImage: UIImage) {
        DispatchQueue.main.async {
            self.image = newImage
        }
    }
}

extension CheckPresenter {
    func onAppearCameraPreview() {
        interactor.setOnCaptureOutput(outPut: updateImage)
        interactor.startSettion()
    }
    
    func onDisappearCameraPreview() {
        interactor.stopSettion()
    }
    
    func onTapCameraPreview() {
        interactor.takePhoto()
    }
}

extension CheckPresenter {
    func resultLink<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        return NavigationLink(destination: router.makeResultView()) {
            content()
        }
    }
}
