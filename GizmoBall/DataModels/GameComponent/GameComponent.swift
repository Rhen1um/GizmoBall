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
        self.size = CGSize(width: unit, height: unit)
        self.xScale = 1
        self.yScale = 1
        self.nodeSize = 1
        self.position = location
        self.nodePosition = CGPoint(x: (location.x + 30) / 60, y: (location.y + 30) / 60)
        
        
//        self.physicsBody = SKPhysicsBody(texture: texture, size: self.size)
//        if let physics = self.physicsBody {
//            physics.affectedByGravity = false
//            physics.allowsRotation = false
//            physics.isDynamic = false
//        }
    }
    
    public func changePosition(newPoint: CGPoint) {
        self.nodePosition = newPoint
        self.position = CGPoint(x: self.nodePosition.x * 60 - 30, y: self.nodePosition.y * 60 - 30)
    }
    
    public func changePositionOnPlay(newPoint: CGPoint) {
        self.position = newPoint
    }
    
    public func restore() {
        self.position = CGPoint(x: self.nodePosition.x * 60 - 30, y: self.nodePosition.y * 60 - 30)
    }
    
    public func nodeRotate() {
        self.zRotation = CGFloat(Double.pi / 2 * 3)
    }
    
    public func zoomIn() {
        self.position = CGPoint(x: self.position.x + 30, y: self.position.y + 30)
        self.xScale += 1
        self.yScale += 1
        self.nodeSize += 1
    }
    
    public func zoomOut() { 
        if(self.nodeSize == 1) {
            return
        }
        self.position = CGPoint(x: self.position.x - 30, y: self.position.y - 30)
        self.xScale -= 1
        self.yScale -= 1
        self.nodeSize -= 1
    }
    
    public func makeAction(with ball: Ball) {
        
    }
}
