//
//  LeftBar.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class LeftBar: Bar {
    
    
    
    convenience init(location: CGPoint) {
        self.init(location: location, texture: SKTexture(imageNamed: "bar"))
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "bar"), size: self.size)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = false
        }
        self.name = "LeftBar"
    }
    

}
