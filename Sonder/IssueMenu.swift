//
//  IssueMenu.swift
//  Sonder
//
//  Created by Paul Mielle on 01/06/2020.
//  Copyright © 2020 Paul Mielle. All rights reserved.
//

import SwiftUI
import SpriteKit


// subclass of SKView with an issueId attr
class issueGraphSKView: SKView {
    var issueId: Binding<Int>
    
    init(frame: CGRect, issueId: Binding<Int>) {
        self.issueId = issueId
        super.init(frame: .zero)
        
    }
    // from google (?)
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
}

// issue graph struct
struct IssueMenu: UIViewRepresentable {
    var issueId: Binding<Int>
    
    // make
    func makeUIView(context: Context) -> issueGraphSKView {
        let view = issueGraphSKView(frame: .zero, issueId: issueId)
        view.allowsTransparency = true
        view.backgroundColor = .clear
        
        if let scene = SKScene(fileNamed: "IssueGraph") {
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .clear
            scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)
            view.presentScene(scene)
        }
        return view
    }
    
    // update
    func updateUIView(_ view: issueGraphSKView, context: Context) {
        // re-activate the view if needed
        if self.issueId.wrappedValue == 0 {
            if view.isPaused {
                view.isPaused = false
                if let s = view.scene {
                    // resume dynamic for all nodes
                    for c in s.children {
                        if c.name == "issue" && c.physicsBody?.isDynamic == false {
                            c.physicsBody?.isDynamic = true
                        }
                    }
                    // reset camera
                    let resetcamera = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.3)
                    resetcamera.timingFunction = SpriteKitTimingFunctions.easeOutExpo
                    s.camera?.run(resetcamera, completion: {view.isUserInteractionEnabled = true})
                }
            }
        }
    }
    
}


class IssueGraph: SKScene {
    
    // node that is being dragged around
    var selectednode:SKNode?
    var touchoffset: CGPoint?
    var history:[TouchInfo]?
    var movetofocus: SKAction?
    var slidecamera: SKAction?
    var startpos:CGPoint?
    var v: issueGraphSKView?
    
    func isTouch(start: CGPoint, end: CGPoint) -> Bool {
        let thresh:CGFloat = 3.0
        if (sqrt(pow(end.x - start.x, 2.0) + pow(end.y - start.y, 2.0)) < thresh) {
            return true
        }
        return false
    }
    
    func drawLines() {
        for n in self.children {
            if (n.name == "line") {
                self.removeChildren(in: [n])
            } else if (n.name == "issue") {
                let path = CGMutablePath()
                path.move(to: CGPoint(x:0,y:0))
                path.addLine(to: n.position)
                let line = SKShapeNode(path: path)
                line.strokeColor = UIColor.label
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
    
    override func didMove(to view: SKView) {
                
        // downcast to issueGraphSKView to be able to access issueId
        self.v = self.view as? issueGraphSKView
        // build the focus action
        let focusy = self.frame.height / 2 - 120
        self.movetofocus = SKAction.move(to: CGPoint(x: 0, y: focusy), duration: 0.6)
        self.movetofocus?.timingFunction = SpriteKitTimingFunctions.easeOutExpo
        // and the camera slide action
        let focusx = self.frame.width / 2 - 130
        self.slidecamera = SKAction.move(by: CGVector(dx: focusx, dy:0), duration: 0.6)
        self.slidecamera?.timingFunction = SpriteKitTimingFunctions.easeOutExpo
        
        
        // build a camera
        let camera = SKCameraNode()
        scene?.addChild(camera)
        self.camera = camera
        

        // generate root node
        let rootnode = SKShapeNode(circleOfRadius: 10)
        rootnode.fillColor = UIColor.clear
        rootnode.strokeColor = UIColor.clear
        rootnode.name = "root"
        rootnode.physicsBody = SKPhysicsBody(polygonFrom: rootnode.path!)
        rootnode.physicsBody?.categoryBitMask = 0
        rootnode.physicsBody?.pinned = true
        rootnode.physicsBody?.mass = 1.0
        self.addChild(rootnode)
        
        // generate test nodes
        var radius:Int?
        var posmin:Int?
        let posmax:Int = Int(self.frame.width / 3)
        var xval:Int?
        for i in 1...8 {
            
            //radius = Int.random(in: 40...100)
            radius = 66
            posmin = radius! + 40
            
            xval = Int.random(in: posmin!...posmax)

            // random startpos on a circle of radius xval
            let angle = Float.random(in: 0...1) * Float.pi * 2;
            let randx = CGFloat(cos(angle) * Float(xval!))
            let randy = CGFloat(sin(angle) * Float(xval!))
            
            // issue node
            let issueNode = SKShapeNode(circleOfRadius: CGFloat(radius!))
            issueNode.fillColor = UIColor.white
            issueNode.fillTexture = SKTexture.init(imageNamed: "goals/\(i)")// blabla
            issueNode.strokeColor = UIColor.label
            issueNode.position = CGPoint(x: randx, y: randy)
            issueNode.name = "issue"
            issueNode.physicsBody = SKPhysicsBody(polygonFrom: issueNode.path!)
            issueNode.physicsBody?.mass = 1.0
            issueNode.physicsBody?.affectedByGravity = false
            issueNode.physicsBody?.linearDamping = 10
            
            // add reverse gravity field
            let shield = SKFieldNode.radialGravityField()
            shield.strength = -5
            shield.falloff = 0
            issueNode.addChild(shield)

            // add issue node
            self.addChild(issueNode)
            
            // spring joint
            let spring = SKPhysicsJointSpring.joint(
                withBodyA: issueNode.physicsBody!,
                bodyB: rootnode.physicsBody!,
                anchorA: issueNode.position,
                anchorB: rootnode.position
                )
            spring.frequency = 5.0
            spring.damping = 0.9
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
            
            if isTouch(start: self.startpos!, end: self.selectednode!.position) {
                self.view?.isUserInteractionEnabled = false
                self.v?.issueId.wrappedValue = 666
                self.camera?.run(slidecamera!)
                self.selectednode?.run(movetofocus!, completion: {
                    self.view?.isPaused = true
                })
            } else if let history = history, history.count > 1 {
                
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
