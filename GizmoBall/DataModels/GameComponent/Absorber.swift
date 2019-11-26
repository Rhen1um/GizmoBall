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
        self.physicsBody = SKPhysicsBody(circleOfRadius: unit / 2)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = false
            physics.categoryBitMask = PhysicsCategory.absorber
            physics.contactTestBitMask = PhysicsCategory.ball
        }
    }
    
    override public func makeAction(with ball: Ball) {
        ball.removeFromParent()
    }
}
