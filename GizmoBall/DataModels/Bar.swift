//
//  Bar.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class Bar: GameComponent {
    
    convenience init(location: CGPoint, texture: SKTexture) {
        self.init(location: location, texture: texture)
    }
    
    
    public func restore() {
        self.position = CGPoint(x: self.nodePosition.x * 60 - 30, y: self.nodePosition.y * 60 - 30)
    }
}

