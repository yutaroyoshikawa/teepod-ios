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
    
    @Published var tiredness: Double? = nil {
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
    
    func updateFaceAttributes(faceAttributes: FaceAPIReturnModel.Attribute) {
        let newtral = faceAttributes.emotion.neutral * 60
        let happiness = faceAttributes.emotion.happiness * 10
        let sadness = faceAttributes.emotion.sadness * 2000
        let fear = faceAttributes.emotion.fear * 2000
        DispatchQueue.main.async {
            self.tiredness = min(max(newtral + sadness + fear - happiness, 0), 100)
        }
    }
}

extension CheckPresenter {
    func onAppearCameraPreview() {
        interactor.setOnCaptureOutput(outPut: { image in
            guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
            self.updateImage(newImage: image)
            self.interactor.requestPostFaceDetect(imageData: imageData)
                .subscribe(Subscribers.Sink<[FaceAPIReturnModel], Error>(
                    receiveCompletion: { _ in },
                    receiveValue: { result in
                        self.updateFaceAttributes(faceAttributes: result[0].faceAttributes)
                    }
                ))
        })
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
    func resultLink<Content: View>(tiredness: Int, isActive: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeResultView(tiredness: tiredness), isActive: isActive) {
            content()
        }
    }
}
