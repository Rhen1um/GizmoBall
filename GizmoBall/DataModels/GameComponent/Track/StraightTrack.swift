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
        self.addChild(super.lineNodes!.leftLine)
        self.addChild(super.lineNodes!.rightLine)
        self.addChild(super.lineNodes!.upLine)
        self.addChild(super.lineNodes!.downLine)
        super.lineNodes?.leftLine.physicsBody?.categoryBitMask = PhysicsCategory.track
        super.lineNodes?.rightLine.physicsBody?.categoryBitMask = PhysicsCategory.track
    }
    

}
