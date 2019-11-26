//
//  Absorber.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class Absorber: GameComponent {
    
    convenience init(location: CGPoint) {
        self.init(location: location, texture: SKTexture(imageNamed: "absorber"))
    }
    
    override public func makeAction(with ball: Ball) {
        ball.removeFromParent()
    }
}
