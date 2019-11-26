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

    convenience init(location: CGPoint) {
        self.init(location: location, texture: SKTexture(imageNamed: "curvedTrack"))
        self.physicsBody = SKPhysicsBody(circleOfRadius: unit / 2)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = false
        }
        self.name = "CurvedTrack"
        super.lineNodes = LineNodes()
        self.addChild(super.lineNodes!.leftLine)
        self.addChild(super.lineNodes!.rightLine)
        self.addChild(super.lineNodes!.upLine)
        self.addChild(super.lineNodes!.downLine)
        super.lineNodes?.downLine.physicsBody?.categoryBitMask = 0x0
        super.lineNodes?.rightLine.physicsBody?.categoryBitMask = 0x0
    }
}
