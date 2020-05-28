//
//  ContentView.swift
//  Sonder
//
//  Created by Paul Mielle on 21/05/2020.
//  Copyright © 2020 Paul Mielle. All rights reserved.
//

import SwiftUI
import SpriteKit


// issue graph struct (SKView)
struct SceneView: UIViewRepresentable {
    let scenename: String
    
    // make
    func makeUIView(context: Context) -> SKView {
        // Let SwiftUI handle the sizing
        let view = SKView(frame: .zero)
        if let scene = SKScene(fileNamed: self.scenename) {
            scene.scaleMode = .aspectFill
            scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)
            view.presentScene(scene)
        }
        return view
    }
    
    // update
    func updateUIView(_ uiView: SKView, context: Context) {
        // ...
    }
    
}


// displayed struct
struct ContentView: View {
    
    var body: some View {
        
        SceneView(scenename: "IssueGraph")
        
    }
    
}


// preview stuff
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
