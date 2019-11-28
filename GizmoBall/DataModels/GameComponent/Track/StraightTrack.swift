//
//  StraightTrack.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class StraightTrack: Track {
    var _field: SKFieldNode?
    
    var field: SKFieldNode? {
        get {
            if _field == nil, let fieldNode = self.childNode(withName: "Field") as? SKFieldNode {
                _field = fieldNode
            }
            return _field
        }
    }
    
    
    convenience init(location: CGPoint) {
        self.init(location: location, texture: SKTexture(imageNamed: "straightTrack"))
        self.name = "StraightTrack"
        super.lineNodes = LineNodes()
//        self.addChild(super.lineNodes!.leftLine)
//        self.addChild(super.lineNodes!.rightLine)
        self.addChild(super.lineNodes!.upLine)
        self.addChild(super.lineNodes!.downLine)
        // update
        // 设置line的category为 100， contactMask为 001, collisionMask 为 111
        // 此时Ball 的 category 为 001, contactMask为 110, collisionMask 为 001
        // 此时可以检测到接触，但不会发生碰撞(line的category & Ball的collisionMask == 0)
//        super.lineNodes?.leftLine.physicsBody?.categoryBitMask = PhysicsCategory.track
//        super.lineNodes?.leftLine.physicsBody?.contactTestBitMask = PhysicsCategory.ball
//        super.lineNodes?.rightLine.physicsBody?.categoryBitMask = PhysicsCategory.track
//        super.lineNodes?.rightLine.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        super.lineNodes?.downLine.physicsBody?.categoryBitMask = PhysicsCategory.shape
        super.lineNodes?.downLine.physicsBody?.contactTestBitMask = PhysicsCategory.none
        super.lineNodes?.upLine.physicsBody?.categoryBitMask = PhysicsCategory.shape
        super.lineNodes?.upLine.physicsBody?.contactTestBitMask = PhysicsCategory.none
        let gravityVector = vector_float3(0, 9.8, 0)
        let field = SKFieldNode.linearGravityField(withVector: gravityVector)
        field.region = SKRegion(size: CGSize(width: unit, height: unit))
        field.isEnabled = true
        field.name = "Field"
        self.addChild(field)
    }
    
    
    override func nodeRotate() {
        super.nodeRotate()
        self.field?.zRotation += CGFloat(Double.pi / 2)
    }
}

extension StraightTrack {
    override static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
}
