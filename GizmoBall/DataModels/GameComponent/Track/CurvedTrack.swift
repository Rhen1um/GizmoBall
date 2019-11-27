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
    }
}
