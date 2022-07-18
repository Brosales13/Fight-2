//
//  ViewController.swift
//  Fight
//
//  Created by Brian Rosales on 5/25/22.
//


import UIKit
import RealityKit
//brings in the 3D modelsdels
class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File (possibly put any 3D model here
       // let boxAnchor = try! FireballJustu.loadScene()
        
        // Add the box anchor to the scene
        //arView.scene.anchors.append(boxAnchor)
    }
}
