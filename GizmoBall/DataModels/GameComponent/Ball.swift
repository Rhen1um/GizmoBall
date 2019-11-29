//
//  Ball.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class Ball: GameComponent {
    
    convenience init(location: CGPoint) {
        self.init(location: location, texture: SKTexture(imageNamed: "ball"))
        self.physicsBody = SKPhysicsBody(circleOfRadius: unit / 2 - 3)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.restitution = 1
            physics.friction = 0
            physics.linearDamping = 0
            // new
            physics.isDynamic = false
            physics.categoryBitMask = PhysicsCategory.ball
            physics.contactTestBitMask = PhysicsCategory.absorber | PhysicsCategory.track
            physics.usesPreciseCollisionDetection = true
            // update
            physics.collisionBitMask = PhysicsCategory.ball
            
//            physics.collisionBitMask = 0x0
        }
        self.name = "Ball"
    }
    
    override func zoomIn() -> Bool {
        return false
    }
    
    override func zoomOut() -> Bool{
        return false
    }
    
    public func enableGravity() {
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = true
    }
    
    public func disableGravity() {
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
    }
    
}

extension Ball {
    override static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
}
