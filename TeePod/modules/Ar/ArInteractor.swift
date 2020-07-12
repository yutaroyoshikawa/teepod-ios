//
//  ArInteractor.swift
//  TeePod
//
//  Created by 吉川勇太郎 on 2020/06/19.
//  Copyright © 2020 TeePod. All rights reserved.
//

import ARKit
import Foundation
import SceneKit
import SwiftUI

final class ArInteractor: NSObject {
    private let sceneView = ARSCNView()
    
    func setupAR() -> CALayer {
        sceneView.scene = SCNScene()
        sceneView.autoenablesDefaultLighting = true
        sceneView.delegate = self
        
        return sceneView.layer
    }
    
    func startSettion() {
        let configuration = ARWorldTrackingConfiguration()
        guard let detectionObjects = ARReferenceObject.referenceObjects(
            inGroupNamed: "AR Resources",
            bundle: nil
        ) else {
            fatalError("Missing expected asset catalog resources.")
        }
        configuration.detectionObjects = detectionObjects
        sceneView.session.run(configuration)
    }
    
    func stopSettion() {
        sceneView.session.pause()
    }
}

extension ArInteractor: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        /*
         Check To See Whether AN ARObject Anhcor Has Been Detected
         Get The The Associated ARReferenceObject
         Get The Name Of The ARReferenceObject
         */
        guard let objectAnchor = anchor as? ARObjectAnchor else { return }
        
        let detectedObject = objectAnchor.referenceObject
        guard let detectedObjectName = detectedObject.name else { return }
        
        // Get The Extent & Center Of The ARReferenceObject
        let detectedObjectExtent = detectedObject.extent
        let detectedObjecCenter = detectedObject.center
        
        // Log The Data
        print("""
        An ARReferenceObject Named \(detectedObjectName) Has Been Detected
        The Extent Of The Object Is \(detectedObjectExtent)
        The Center Of The Object Is \(detectedObjecCenter)
        """)
        
        let plane = SCNPlane(width: CGFloat(0.3),
                             height: CGFloat(0.3))
        
        let planeNode = SCNNode(geometry: plane)
        
        planeNode.position = SCNVector3Make(detectedObject.center.x, detectedObject.center.y + 0.2, detectedObject.center.z)
        
        createHostingController(for: planeNode)
        node.addChildNode(planeNode)
    }
    
    func createHostingController(for node: SCNNode) {
        let arVC = UIHostingController(rootView: ParipiClock())
        
        DispatchQueue.main.async {
            arVC.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
            self.show(hostingVC: arVC, on: node)
        }
    }
    
    func show(hostingVC: UIHostingController<ParipiClock>, on node: SCNNode) {
        let material = SCNMaterial()
        hostingVC.view.isOpaque = false
        material.diffuse.contents = hostingVC.view
        node.geometry?.materials = [material]
        hostingVC.view.backgroundColor = UIColor.clear
    }
}
