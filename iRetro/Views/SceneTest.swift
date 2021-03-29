//
//  Test.swift
//  SwiftUI-Jam-2020
//
//  Created by Andreas on 2/19/21.
//

import SwiftUI
import AVFoundation
import SwiftUI
import UIKit
import SceneKit
struct AudioView: View {
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
                   
                    audioSource = SCNAudioSource(fileNamed: "002.mp3")!
                    scene.background.contents = UIColor.white
                    audioSource.loops = true
                    audioSource.load()
                    cameraNode.position = SCNVector3(x:0, y: 0, z: 50)
                    cameraNode.pivot = SCNMatrix4MakeTranslation(0, 0, 90)
                    audioSource.isPositional = true
                    
                    for i in (-1...1) {
                        let box = SCNBox(width: 27, height: 27*1.8, length: 5, chamferRadius: 0)
                    //box.firstMaterial?.diffuse.contents = UIColor.red
                        let node = SCNNode(geometry: box)
                        node.rotation = SCNVector4Make(0.2, 0.2, 0.2, -.pi / 4)
                        let roteAction = SCNAction.rotate(toAxisAngle: SCNVector4Make(1, 1, 0, -.pi / 8), duration: 10)
                       
                        node.runAction(roteAction)
                       
                        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                        
                            let roteAction = SCNAction.rotate(toAxisAngle: SCNVector4Make(0, 0, 0, 0), duration: 2.0)
                            roteAction.reversed()
                            node.runAction(roteAction)
                           
                            
                        }
                        
                        node.position = SCNVector3(i*50,0,0)
                       
                        createHostingController(for: box)
                        
                    //  node.addAudioPlayer(SCNAudioPlayer(source: audioSource))
                    scene.rootNode.addChildNode(node)
                        
                    }
                    for i in (-1...1) {
                    let box = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 0)
                    box.firstMaterial?.diffuse.contents = UIColor.red
                        let node = SCNNode(geometry: box)
                   
                        node.position = SCNVector3(i*50,20,0)
                        node.addAudioPlayer(SCNAudioPlayer(source: audioSource))
                    //scene.rootNode.addChildNode(node)
                        let roteAction = SCNAction.rotate(by: 3.14, around: node.position, duration: 5)
                       // node.runAction(roteAction)
                        //node.addAudioPlayer(SCNAudioPlayer(avAudioNode: MusicManager.shared.player))
                        //node.audioPlayers.first?.audioSource?.volume = 0
                      
                        
                        
                    }
                    for i in (-1...1) {
                    let box = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 0)
                    box.firstMaterial?.diffuse.contents = UIColor.red
                        let node = SCNNode(geometry: box)
                        
                        node.position = SCNVector3(i*50,40,0)
                        node.addAudioPlayer(SCNAudioPlayer(source: audioSource))
                   // scene.rootNode.addChildNode(node)
                        node.rotation = SCNVector4(90, 0, 0, 0)
                        //node.addAudioPlayer(SCNAudioPlayer(source: audioSource))
                        //node.addAudioPlayer(SCNAudioPlayer(avAudioNode: load(file: "1", ofType: "mp3")))
                       
                       
                    }
                    
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
        let arVC = UIHostingController(rootView: iPodClassic())
           
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
        
        let mat2 = SCNMaterial()
        mat2.diffuse.contents = UIColor.secondarySystemFill
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
