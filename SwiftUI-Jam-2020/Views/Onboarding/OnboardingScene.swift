//
//  OnboardingScene.swift
//  SwiftUI-Jam-2020
//
//  Created by Andreas on 2/19/21.
//

import SwiftUI
import AVFoundation
import SwiftUI
import UIKit
import SceneKit
struct OnboardingScene: View {
    var scene = SCNScene()
    
    var cameraNode = SCNNode()
    @State var audioSource = SCNAudioSource()
    
   

    @State var ready = false
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .onAppear(perform: {
                    
                    // As an environmental sound layer, audio should play indefinitely
                    
                    // Decode the audio from disk ahead of time to prevent a delay in playback
                   
                   
                    scene.background.contents = UIColor.white
                   
                    cameraNode.position = SCNVector3(x:0, y: 0, z: 50)
                    cameraNode.pivot = SCNMatrix4MakeTranslation(0, 0, 90)
                   
                    
                   
                        let box = SCNBox(width: 27, height: 27*1.8, length: 5, chamferRadius: 32)
                    //box.firstMaterial?.diffuse.contents = UIColor.red
                        let node = SCNNode(geometry: box)
                        node.rotation = SCNVector4Make(0.2, 0.2, 0.2, -.pi / 4)
                        let roteAction = SCNAction.rotate(toAxisAngle: SCNVector4Make(1, 1, 0, -.pi / 8), duration: 30)
                       
                        node.runAction(roteAction)
                       
                      
                        
                        node.position = SCNVector3(0,10,0)
                       
                        createHostingController(for: box)
                        
                    //  node.addAudioPlayer(SCNAudioPlayer(source: audioSource))
                    scene.rootNode.addChildNode(node)
                        
                    
                 
                    
                    ready = true
                    
                   
                })
            
            SceneView(
                scene: scene,
                pointOfView: cameraNode, options: [], preferredFramesPerSecond: 60
            )
            
    }
    }
    func createHostingController(for node: SCNBox) {
           // create a hosting controller with SwiftUI view
        let arVC = UIHostingController(rootView: iPodClassic(isOnboarding: true))
           
           // Do this on the main thread
           DispatchQueue.main.async {
               
               // make the hosting VC a child to the main view controller
               //self.addChild(arVC)
               
               // set the pixel size of the Card View
            let width = screenDemensions.width - 48
            let height = width*1.8
            arVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
               
               // add the ar card view as a subview to the main view
              // self.view.addSubview(arVC.view)
               
               // render the view on the plane geometry as a material
               self.show(hostingVC: arVC, on: node)
           }
       }
       
       func show(hostingVC: UIHostingController<iPodClassic>, on node: SCNBox) {
           // create a new material
           let material = SCNMaterial()
           
           // this allows the card to render transparent parts the right way
           hostingVC.view.isOpaque = false
           
           // set the diffuse of the material to the view of the Hosting View Controller
        material.diffuse.contents = hostingVC.view
           
           // Set the material to the geometry of the node (plane geometry)
        let arVC = UIHostingController(rootView: iPodSides())
        let width = screenDemensions.width - 48
        let height = width*1.8
        arVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        let mat2 = SCNMaterial()
        arVC.view.isOpaque = false
        mat2.diffuse.contents = arVC.view
        node.materials =  [material,  mat2,    mat2,
                           mat2, mat2, mat2]
          // hostingVC.view.backgroundColor = UIColor.white
       }

    func centerPivot(for node: SCNNode) {
       var min = SCNVector3Zero
       var max = SCNVector3Zero
       node.__getBoundingBoxMin(&min, max: &max)
       node.pivot = SCNMatrix4MakeTranslation(
           min.x + (max.x - min.x)/2,
           min.y + (max.y - min.y)/2,
           min.z + (max.z - min.z)/2
       )
   }
}

