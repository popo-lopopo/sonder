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
    
    func makeUIView(context: Context) -> SKView {
        // Let SwiftUI handle the sizing
        return SKView(frame: .zero)
    }
    func updateUIView(_ uiView: SKView, context: Context) {
        if let scene = SKScene(fileNamed: "IssueGraph") {
            scene.scaleMode = .aspectFill
            uiView.presentScene(scene)
        }
    }
}


// displayed struct
struct ContentView: View {
    var body: some View {
        SceneView()
    }
}


// preview stuff
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
