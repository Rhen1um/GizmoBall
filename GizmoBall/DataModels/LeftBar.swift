//
//  LeftBar.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class LeftBar: GameComponent {
    
    convenience init(location: CGPoint) {
        self.init(location: location, texture: SKTexture(imageNamed: ""))
    }
    
    override func makeAction(with otherComponent: GameComponent) {
        
    }
}
