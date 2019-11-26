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
        self.physicsBody = SKPhysicsBody(circleOfRadius: unit / 2)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = false
            physics.categoryBitMask = PhysicsCategory.ball
            physics.contactTestBitMask = PhysicsCategory.track + PhysicsCategory.absorber
            
        }

    }

    public func startPlay() {
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = true
    }
    
    public func changeGravity() {
        self.physicsBody?.affectedByGravity = !(self.physicsBody?.affectedByGravity ?? false)
    }
}
