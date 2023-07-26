//
//  ARView.swift
//  FaceMesh
//
//  Created by Bianca Nathally Bezerra de Lima on 26/07/23.
//

import SwiftUI
import ARKit

struct ARView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Update any parameters or settings of the view controller if needed
    }
}
