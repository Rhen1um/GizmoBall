//
//  Track.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class Track: GameComponent {
    
    convenience init(location: CGPoint, texture: SKTexture) {
        self.init(location: location, texture: texture)
    }
    
    override func makeAction(with otherComponent: GameComponent) {
        
    }
}
