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
    var history:[TouchInfo]?
    var movetofocus: SKAction?
    var movecameratofocus: SKAction?
    var startpos:CGPoint?
    var v: issueGraphSKView?
    
    func drawLines() {
        for n in self.children {
            if (n.name == "line") {
                self.removeChildren(in: [n])
            } else if (n.name == "issue") {
                let path = CGMutablePath()
                path.move(to: CGPoint(x:0,y:0))
                path.addLine(to: n.position)
                let line = SKShapeNode(path: path)
                line.name = "line"
                line.zPosition = -1
                self.addChild(line)
            }
            
        }
    }
    
    struct TouchInfo {
        var location:CGPoint
        var time:TimeInterval
    }
    
    func freezescene() {
        drawLines()
        self.isPaused = true
        self.view?.isPaused = true
        //v?.issueId.wrappedValue = 12
    }
    
    func runfocus() {
        self.selectednode?.physicsBody?.isDynamic = false
        self.selectednode?.run(movetofocus!, completion: freezescene)
        self.camera?.run(movecameratofocus!)
    }
    
    override func didMove(to view: SKView) {
        
        // downcast to issueGraphSKView to be able to access issueId
        self.v = self.view as? issueGraphSKView
        
        // setup the camera
        let cameraNode = SKCameraNode()
        self.addChild(cameraNode)
        self.camera = cameraNode
        
        // build the focus action
        let focusy = self.frame.height / 2 - 230
        self.movetofocus = SKAction.move(to: CGPoint(x: 500, y: focusy), duration: 3)
        self.movetofocus?.timingMode = .easeInEaseOut
        
        // build the camera focus action
        let focuscamerax = self.frame.width / 2 - 100 + 500
        self.movecameratofocus = SKAction.move(to: CGPoint(x: focuscamerax, y: 0), duration: 2)
        self.movecameratofocus?.timingMode = .easeInEaseOut
        
        // generate root node
        let rootnode = SKShapeNode(circleOfRadius: 10)
        rootnode.fillColor = UIColor.red
        rootnode.name = "root"
        rootnode.physicsBody = SKPhysicsBody(polygonFrom: rootnode.path!)
        rootnode.physicsBody?.pinned = true
        rootnode.physicsBody?.mass = 1.0
        self.addChild(rootnode)
        
        // generate test nodes
        let posmin:Int = 40
        let posmax:Int = Int(self.frame.width / 5)
        for _ in 1...5 {
            let xnegval = Int.random(in:(-posmax)...(-posmin))
            let xposval = Int.random(in:posmin...posmax)
            let xchoice = Int.random(in:1...2)
            let xpos:Int?
            if xchoice == 1 {
                xpos = xposval
            } else {
                xpos = xnegval
            }
            let ynegval = Int.random(in:(-posmax)...(-posmin))
            let yposval = Int.random(in:posmin...posmax)
            let ychoice = Int.random(in:1...2)
            let ypos:Int?
            if ychoice == 1 {
                ypos = yposval
            } else {
                ypos = ynegval
            }
            let issueNode = SKShapeNode(circleOfRadius: 50)
            issueNode.fillColor = UIColor.blue
            issueNode.position = CGPoint(x: xpos!, y: ypos!)
            issueNode.name = "issue"
            issueNode.physicsBody = SKPhysicsBody(polygonFrom: issueNode.path!)
            issueNode.physicsBody?.mass = 1.0
            issueNode.physicsBody?.affectedByGravity = false
            issueNode.physicsBody?.linearDamping = 10.0;
            // add reverse gravity field
            let shield = SKFieldNode.radialGravityField()
            shield.strength = -10
            shield.falloff = 0
            issueNode.addChild(shield)
            self.addChild(issueNode)
            // spring joint
            let spring = SKPhysicsJointSpring.joint(
                withBodyA: issueNode.physicsBody!,
                bodyB: rootnode.physicsBody!,
                anchorA: issueNode.position,
                anchorB: rootnode.position
                )
            spring.frequency = 3.0
            spring.damping = 0.2
            self.physicsWorld.add(spring)
        }
    }
    
    func touchDown(atPoint pos : CGPoint, touch: UITouch) {
        let n: SKNode = self.atPoint(pos)
        if n.name == "issue" {
            let offx = pos.x - n.position.x
            let offy = pos.y - n.position.y
            self.selectednode = n
            self.selectednode?.physicsBody?.isDynamic = false
            self.touchoffset = CGPoint(x: offx, y: offy)
            self.history = [TouchInfo(location:pos, time:touch.timestamp)]
            self.startpos = n.position
        }
    }
    
    func touchMoved(toPoint pos : CGPoint, touch: UITouch) {
        let location = touch.location(in:self)
        if self.selectednode != nil {
            let newpos = CGPoint(x: pos.x - self.touchoffset!.x, y: pos.y - self.touchoffset!.y)
            self.selectednode?.position = newpos
            self.history?.insert(TouchInfo(location:location, time:touch.timestamp),at:0)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if self.selectednode != nil {
            
            if self.selectednode?.position == self.startpos {
                runfocus()
            }
            
            if let history = history, history.count > 1 {
                var vx:CGFloat = 0.0
                var vy:CGFloat = 0.0
                var previousTouchInfo:TouchInfo?
                // Adjust this value as needed
                let maxIterations = 3
                let numElts:Int = min(history.count, maxIterations)
                // Loop over touch history
                for index in 0..<numElts {
                    let touchInfo = history[index]
                    let location = touchInfo.location
                    if let previousTouch = previousTouchInfo {
                        // Step 1
                        let dx = location.x - previousTouch.location.x
                        let dy = location.y - previousTouch.location.y
                        // Step 2
                        let dt = CGFloat(touchInfo.time - previousTouch.time)
                        // Step 3
                        vx += dx / dt
                        vy += dy / dt
                    }
                    previousTouchInfo = touchInfo
                }
                let count = CGFloat(numElts-1)
                // Step 4
                let velocity = CGVector(dx:vx/count,dy:vy/count)
                self.selectednode?.physicsBody?.isDynamic = true
                self.selectednode?.physicsBody?.velocity = velocity
            }
            self.selectednode = nil
            self.touchoffset = nil
            self.history = nil
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self), touch: t)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self), touch: t) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        drawLines()
    }
    
    
}
