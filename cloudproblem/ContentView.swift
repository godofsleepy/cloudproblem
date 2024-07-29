//
//  ContentView.swift
//  cloudproblem
//
//  Created by Rifat Khadafy on 27/07/24.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    var body: some View {
        VStack {
            SceneKitView()
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height / 2)
        }
    }
}

struct SceneKitView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = false
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.backgroundColor = .clear
        
        if let scene = SCNScene(named: "Purple_Lightning_Rainstorm.scn") {
            
            playAnimationKeys(for: scene.rootNode)
            view.scene = scene
            view.scene?.isPaused = false
            
        } else {
            print("Failed to load the scene.")
        }
        
        
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
    
    func playAnimationKeys(for node: SCNNode) {
        let animationKeys = node.animationKeys
        for key in animationKeys {
            print("Node: \(node.name ?? "Unnamed"), Animation Key: \(key)")
            if let animationPlayer = node.animationPlayer(forKey: key) {
                animationPlayer.play()
            } else {
                print(" -> No Animation Player found for key \(key)")
            }
        }
        
        for child in node.childNodes {
            playAnimationKeys(for: child)
        }
    }
}


#Preview {
    ContentView()
}
