//
//  RigtheBar.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class RightBar: Bar {
    
    convenience init(location: CGPoint) {
        self.init(location: location, texture: SKTexture(imageNamed: "bar"))
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: -30, y: -30), CGPoint(x: 30, y: -30), CGPoint(x: 30, y: -25), CGPoint(x: -30, y: -25), CGPoint(x: -30, y: -30)])
        path.closeSubpath()
        self.physicsBody = SKPhysicsBody(polygonFrom: path)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = false
        }
        
        self.name = "RightBar"
    }
    

}


extension RightBar {
    override static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
}
