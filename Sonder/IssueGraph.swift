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
    var touchoffset: CGPoint?
    
    override func didMove(to view: SKView) {
        
        // generate root node
        let rootnode = SKShapeNode(circleOfRadius: 20)
        rootnode.fillColor = UIColor.red
        rootnode.name = "root"
        rootnode.physicsBody = SKPhysicsBody(polygonFrom: rootnode.path!)
        rootnode.physicsBody?.pinned = true
        self.addChild(rootnode)
        // generate 4 test nodes
        for i in 1...4 {
            let issueNode = SKShapeNode(circleOfRadius: 50)
            issueNode.fillColor = UIColor.blue
            issueNode.position = CGPoint(x: 10, y: i * 100)
            issueNode.name = "issue"
            issueNode.physicsBody = SKPhysicsBody(polygonFrom: issueNode.path!)
            issueNode.physicsBody?.affectedByGravity = false
            issueNode.physicsBody?.linearDamping = 10.0;
            self.addChild(issueNode)
            // spring joint
            let spring = SKPhysicsJointSpring.joint(
                withBodyA: issueNode.physicsBody!,
                bodyB: rootnode.physicsBody!,
                anchorA: issueNode.position,
                anchorB: rootnode.position
                )
            spring.frequency = 5.0
            self.physicsWorld.add(spring)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        let n: SKNode = self.atPoint(pos)
        if n.name == "issue" {
            n.physicsBody?.isDynamic = false
            let offx = pos.x - n.position.x
            let offy = pos.y - n.position.y
            self.selectednode = n
            self.touchoffset = CGPoint(x: offx, y: offy)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if self.selectednode != nil {
            let newpos = CGPoint(x: pos.x - self.touchoffset!.x, y: pos.y - self.touchoffset!.y)
            self.selectednode?.position = newpos
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if self.selectednode != nil {
            self.selectednode!.physicsBody?.isDynamic = true
            self.selectednode = nil
            self.touchoffset = nil
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
