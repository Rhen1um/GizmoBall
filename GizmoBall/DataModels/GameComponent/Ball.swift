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
        self.physicsBody = SKPhysicsBody(circleOfRadius: unit / 2 - 1)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            // new
            physics.isDynamic = false
            physics.categoryBitMask = PhysicsCategory.ball
            physics.contactTestBitMask = PhysicsCategory.absorber
            physics.usesPreciseCollisionDetection = true
            
//            physics.collisionBitMask = 0x0
        }
        self.name = "Ball"
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
    
    public func changeGravity() {
        self.physicsBody?.affectedByGravity = !(self.physicsBody?.affectedByGravity ?? false)
    }
}
