//
//  IssueGraph.swift
//  Sonder
//
//  Created by Paul Mielle on 24/05/2020.
//  Copyright © 2020 Paul Mielle. All rights reserved.
//

import SpriteKit

class IssueGraph: SKScene {
    
    // node that is being dragged around
    var selectednode:SKNode?
    
    override func didMove(to view: SKView) {
        // generate 4 test nodes
        for i in 1...4 {
            let issueNode = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 100, height: 100))
            issueNode.position = CGPoint(x: 0, y: i * 100)
            issueNode.name = "issue"
            self.addChild(issueNode)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if self.atPoint(pos).name == "issue" {
            self.selectednode = self.atPoint(pos)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if self.selectednode != nil {
            self.selectednode?.position = pos
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if self.selectednode != nil {
            self.selectednode = nil
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
}
