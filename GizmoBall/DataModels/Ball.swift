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
        self.init(location: location, texture: SKTexture(imageNamed: ""))
        self.physicsBody?.isDynamic = true
    }
    
    public func startPlay() {
        self.physicsBody?.affectedByGravity = true
    }
    
    public func restore() {
        self.position = CGPoint(x: self.nodePosition.x * 60 - 30, y: self.nodePosition.y * 60 - 30)
    }
    
    public func changeGravity() {
        self.physicsBody?.affectedByGravity = !(self.physicsBody?.affectedByGravity ?? false)
    }
}
