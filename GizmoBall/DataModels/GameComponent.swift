//
//  GameComponent.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class GameComponent: SKSpriteNode{
    var nodePosition = CGPoint(x: 0, y: 0)
    var nodeSize: Int = 0
    
    convenience init(location: CGPoint, texture: SKTexture) {
        self.init(texture: texture)
        self.xScale = 1
        self.yScale = 1
        self.nodeSize = 1
        self.position = location
        self.nodePosition = CGPoint(x: (location.x - 30) / 60, y: (location.y - 30) / 60)
        
        self.physicsBody = SKPhysicsBody(texture: texture, size: self.size)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = true
            physics.isDynamic = true
            physics.linearDamping = 0.75
            physics.angularDamping = 0.75
        }
    }
    
    public func changePosition(newPoint: CGPoint) {
        self.nodePosition = newPoint
    }
    
    public func nodeRotate() {
    }
    
    public func zoomIn() {
        self.nodeSize += 1
    }
    
    public func zoomOut() {
        if(self.nodeSize == 1) {
            return
        }
        self.nodeSize -= 1
    }
    
    public func makeAction(with otherComponent: GameComponent) {
        
    }
}
