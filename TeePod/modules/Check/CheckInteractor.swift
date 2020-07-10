//
//  CheckInteractor.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import AVFoundation
import Combine
import Foundation
import Moya
import UIKit

final class CheckInteractor: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    private let captureSession = AVCaptureSession()
    private var captureDevice: AVCaptureDevice?
    private let api = MoyaProvider<FaceAPI>()
    
    private var onCaptureOutput: ((UIImage) -> Void)?
    
    private var _takePhoto: Bool = false
    
    func setOnCaptureOutput(outPut: @escaping (UIImage) -> Void) {
        onCaptureOutput = outPut
    }
    
    func setupAVCaptureSession() -> CALayer {
        captureSession.sessionPreset = .photo
        if let availableDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices.first {
            captureDevice = availableDevice
        }
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error.localizedDescription)
        }
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        captureSession.commitConfiguration()
        
        let queue = DispatchQueue(label: "FromF.github.com.AVFoundationSwiftUI.AVFoundation")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.name = "CameraPreview"
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.backgroundColor = UIColor.black.cgColor
        
        return previewLayer
    }
    
    func startSettion() {
        if captureSession.isRunning { return }
        captureSession.startRunning()
    }
    
    func stopSettion() {
        if !captureSession.isRunning { return }
        captureSession.stopRunning()
    }
    
    func takePhoto() {
        _takePhoto = true
    }
    
    private func getImageFromSampleBuffer(buffer: CMSampleBuffer) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
        }
        
        return nil
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if _takePhoto {
            _takePhoto = false
            if let image = getImageFromSampleBuffer(buffer: sampleBuffer) {
                if onCaptureOutput != nil {
                    onCaptureOutput!(image)
                }
            }
        }
    }
    
    func requestPostFaceDetect(imageData: Data) -> Future<[FaceAPIReturnModel], Error> {
        Future { promise in
            self.api.request(FaceAPI.detect(imageData: imageData)) { result in
                switch result {
                case let .success(response):
                    do {
                        let json = try response.map([FaceAPIReturnModel].self)
                        promise(.success(json))
                    } catch {
                        promise(.failure(error))
                    }
                case let .failure(error):
                    dump(error.errorDescription)
                    promise(.failure(error))
                }
            }
        }
    }
}
