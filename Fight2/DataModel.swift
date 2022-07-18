//
//  DataModel.swift
//  Fight
//
//  Created by Brian Rosales on 5/25/22.
//

import SwiftUI
import RealityKit
import Combine

final class DataModel: ObservableObject {
    static var shared = DataModel()
    

    @Published var arView: ARView!
    @Published var enableAR = true
       
   
    
    // Makes the 3D Models show up
    init() {
        //initialise the ARView
        arView = ARView(frame: .zero)
        
        //load the "BOX" scene from the "Expereience" Reality File
        let allMightFig = try! AllMightScene.loadScene()
        
        
        //Add the box anchor to the scene
        arView.scene.anchors.append(allMightFig)
        
        arView.scene.anchors.first?.transform.rotation = simd_quatf(ix:  0.659, iy: -0.361, iz:  0.659, r: 1)
    }
    
}
    
 
