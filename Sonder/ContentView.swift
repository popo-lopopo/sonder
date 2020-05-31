//
//  ContentView.swift
//  Sonder
//
//  Created by Paul Mielle on 21/05/2020.
//  Copyright © 2020 Paul Mielle. All rights reserved.
//

import SwiftUI
import SpriteKit

// issue graph struct
struct SceneView: UIViewRepresentable {
    var issueId: Binding<Int>
    
    // make
    func makeUIView(context: Context) -> issueGraphSKView {
        let view = issueGraphSKView(frame: .zero, issueId: issueId)
        if let scene = SKScene(fileNamed: "IssueGraph") {
            scene.scaleMode = .aspectFill
            scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)
            view.showsFPS = true
            view.presentScene(scene)
        }
        return view
    }
    
    // update
    func updateUIView(_ view: issueGraphSKView, context: Context) {}

}


// displayed struct
struct ContentView: View {
    
    // id of the issue to display
    // if unset, display issue Graph
    @State var issueId = 0
    
    // main
    var body: some View {
        Group {
            if issueId != 0  {
                //print("ISSUE ID IS ::::::::::: \(issueId)")
                Text("Congrats! Issue id is \(issueId)")
            } else {
                //print("ISSUE ID IS ::::::::::: \(issueId)")
                SceneView(issueId: $issueId)
            }
        }
    } // end of body
    
}


// preview stuff
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
