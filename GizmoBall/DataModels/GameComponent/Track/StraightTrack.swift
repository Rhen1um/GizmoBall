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
    
    
    convenience init(location: CGPoint) {
        self.init(location: location, texture: SKTexture(imageNamed: "straightTrack"))
        self.name = "StraightTrack"
        super.lineNodes = LineNodes()
        
        super.lineNodes!.upLine.zPosition = -1
        super.lineNodes!.downLine.zPosition = -1
        self.addChild(super.lineNodes!.upLine)
        self.addChild(super.lineNodes!.downLine)
        super.lineNodes?.downLine.physicsBody?.categoryBitMask = PhysicsCategory.shape
        super.lineNodes?.downLine.physicsBody?.contactTestBitMask = PhysicsCategory.none
        super.lineNodes?.upLine.physicsBody?.categoryBitMask = PhysicsCategory.shape
        super.lineNodes?.upLine.physicsBody?.contactTestBitMask = PhysicsCategory.none
        let gravityVector = vector_float3(0, 9.8, 0)
        let field = SKFieldNode.linearGravityField(withVector: gravityVector)
        field.region = SKRegion(size: CGSize(width: unit, height: unit))
        field.isEnabled = true
        field.name = "Field"
        field.zPosition = -1
        self.addChild(field)
    }
    
}

extension StraightTrack {
    override static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
}
