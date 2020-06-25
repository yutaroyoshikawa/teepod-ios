//
//  ArView.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import SwiftUI
import RealityKit


struct ArView: View {
    @ObservedObject var presenter: ArPresenter
    @ObservedObject private var avFoundationVM = AVFoundationVM()
    
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        // RealityKit のメインとなるビュー
        let arView = ARView(frame: .zero)
        
        // デバッグ用設定
        // 処理の統計情報と、検出した3D空間の特徴点を表示する。
        //        arView.debugOptions = [.showStatistics, .showFeaturePoints]
        
        // シーンにアンカーを追加する
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.15, 0.15])
        arView.scene.anchors.append(anchor)
        
        // テキストを作成
        let textMesh = MeshResource.generateText(
            "12:34",
            extrusionDepth: 0.1,
            font: .systemFont(ofSize: 1.0), // 小さいとフォントがつぶれてしまうのでこれぐらいに設定
            containerFrame: CGRect.zero,
            alignment: .left,
            lineBreakMode: .byTruncatingTail)
        // 環境マッピングするマテリアルを設定
        let textMaterial = SimpleMaterial(color: UIColor.red, roughness: 0.0, isMetallic: true)
        let textModel = ModelEntity(mesh: textMesh, materials: [textMaterial])
        textModel.scale = SIMD3<Float>(0.2, 0.2, 0.2) // 10分の1に縮小
        textModel.position = SIMD3<Float>(0.0, 0.0, -0.2) // 奥0.2m
        anchor.addChild(textModel)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
