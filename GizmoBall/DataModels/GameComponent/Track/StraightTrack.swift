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
        // update
        // 设置line的category为 100， contactMask为 001, collisionMask 为 111
        // 此时Ball 的 category 为 001, contactMask为 110, collisionMask 为 001
        // 此时可以检测到接触，但不会发生碰撞(line的category & Ball的collisionMask == 0)
        super.lineNodes?.leftLine.physicsBody?.categoryBitMask = PhysicsCategory.track
        super.lineNodes?.leftLine.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        super.lineNodes?.rightLine.physicsBody?.categoryBitMask = PhysicsCategory.track
        super.lineNodes?.rightLine.physicsBody?.contactTestBitMask = PhysicsCategory.ball
    }
    

}
