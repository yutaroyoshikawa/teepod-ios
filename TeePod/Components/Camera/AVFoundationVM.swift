//
//  AVFoundationVM.swift
//  TeePod
//
//  Created by 石井知恵子 on 2020/06/23.
//  Copyright © 2020 TeePod. All rights reserved.
//

import AVFoundation
import Combine
import UIKit

class AVFoundationVM: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, ObservableObject {
    /// 撮影した画像
    @Published var image: UIImage?
    /// プレビュー用レイヤー
    var previewLayer: CALayer!
    
    /// 撮影開始フラグ
    private var _takePhoto: Bool = false
    /// セッション
    private let captureSession = AVCaptureSession()
    /// 撮影デバイス
    private var capturepDevice: AVCaptureDevice!
    
    override init() {
        super.init()
        
        prepareCamera()
        beginSession()
    }
    
    func takePhoto() {
        _takePhoto = true
    }
    
    private func prepareCamera() {
        captureSession.sessionPreset = .photo
        
        if let availableDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .front).devices.first {
            capturepDevice = availableDevice
        }
    }
    
    private func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: capturepDevice)
            
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error.localizedDescription)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = previewLayer
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
        captureSession.commitConfiguration()
        
        let queue = DispatchQueue(label: "FromF.github.com.AVFoundationSwiftUI.AVFoundation")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
    }
    
    func startSession() {
        if captureSession.isRunning { return }
        captureSession.startRunning()
    }
    
    func endSession() {
        if !captureSession.isRunning { return }
        captureSession.stopRunning()
    }
    
    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if _takePhoto {
            _takePhoto = false
            if let image = getImageFromSampleBuffer(buffer: sampleBuffer) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
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
}
