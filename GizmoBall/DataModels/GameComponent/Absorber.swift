//
//  Absorber.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class Absorber: GameComponent {
    
    convenience init(location: CGPoint) {
        self.init(location: location, texture: SKTexture(imageNamed: "absorber"))
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: -30, y: 30), CGPoint(x: 30, y: 30), CGPoint(x:30, y: -30), CGPoint(x: -30, y: -30), CGPoint(x: -30, y: 30)])
        path.closeSubpath()
        self.physicsBody = SKPhysicsBody(polygonFrom: path)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            // new
            physics.isDynamic = false
            physics.categoryBitMask = PhysicsCategory.absorber
            physics.contactTestBitMask = PhysicsCategory.ball
            physics.usesPreciseCollisionDetection = true
        }
        self.name = "Absorber"
    }
    
    override func zoomIn() -> Bool{
        return false
    }
    
    override func zoomOut() -> Bool{
        return false
    }
    
    override public func makeAction(with ball: Ball) {
        ball.removeFromParent()
    }
}

extension Absorber {
    override static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
}
