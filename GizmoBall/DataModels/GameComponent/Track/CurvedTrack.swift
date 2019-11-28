//
//  CurvedTrack.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class CurvedTrack: Track {
    
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
        self.init(location: location, texture: SKTexture(imageNamed: "curvedTrack"))
        self.name = "CurvedTrack"
        super.lineNodes = LineNodes()
        super.lineNodes!.rightLine.zPosition = -1
        super.lineNodes!.downLine.zPosition = -1
        super.lineNodes!.curvedLine.zPosition = -1
        self.addChild(super.lineNodes!.rightLine)
        self.addChild(super.lineNodes!.downLine)
        self.addChild(super.lineNodes!.curvedLine)
        super.lineNodes?.downLine.physicsBody?.categoryBitMask = PhysicsCategory.track
        super.lineNodes?.downLine.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        super.lineNodes?.rightLine.physicsBody?.categoryBitMask = PhysicsCategory.track
        super.lineNodes?.rightLine.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        super.lineNodes?.curvedLine.physicsBody?.categoryBitMask = PhysicsCategory.shape
        super.lineNodes?.curvedLine.physicsBody?.contactTestBitMask = PhysicsCategory.none
        let gravityVector = vector_float3(0, 9.8, 0)
        let field = SKFieldNode.linearGravityField(withVector: gravityVector)
        field.region = SKRegion(size: CGSize(width: unit, height: unit))
        field.isEnabled = true
        field.name = "Field"
        field.zPosition = -1
        self.addChild(field)
    }
    
    override func nodeRotate() {
        super.nodeRotate()
        self.field?.zRotation += CGFloat(Double.pi / 2)
    }
    
}

extension CurvedTrack {
    override static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
}
