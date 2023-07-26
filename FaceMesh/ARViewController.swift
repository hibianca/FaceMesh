//
//  ARViewController.swift
//  FaceMesh
//
//  Created by Bianca Nathally Bezerra de Lima on 26/07/23.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    var sceneView: ARSCNView!
    
//    let noseOptions = ["nose01", "nose02", "nose03", "nose04", "nose05", "nose06", "nose07", "nose08", "nose09"]
//    let features = ["nose"]
    var featureIndices = [[6]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView = ARSCNView(frame: view.bounds)
        view.addSubview(sceneView)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARFaceTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: sceneView)
        let results = sceneView.hitTest(location, options: nil)
        if let result = results.first, let node = result.node as? FaceNode {
            node.next()
        }
    }
    
//    func updateFeatures(for node: SCNNode, using anchor: ARFaceAnchor) {
//        for (feature, indices) in zip(features, featureIndices) {
//            let child = node.childNode(withName: feature, recursively: false) as? FaceNode
//            let vertices = indices.map { anchor.geometry.vertices[$0] }
//            child?.updatePosition(for: vertices)
//        }
//    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let device: MTLDevice! = MTLCreateSystemDefaultDevice()
        guard let faceAnchor = anchor as? ARFaceAnchor else {
            return nil
        }
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let node = SCNNode(geometry: faceGeometry)
        node.geometry?.firstMaterial?.fillMode = .lines
        
//        let noseNode = FaceNode(with: noseOptions)
//        noseNode.name = "nose"
//        node.addChildNode(noseNode)
        
//        updateFeatures(for: node, using: faceAnchor)
        
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
              let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
            return
        }
        faceGeometry.update(from: faceAnchor.geometry)
//        updateFeatures(for: node, using: faceAnchor)
    }
}
