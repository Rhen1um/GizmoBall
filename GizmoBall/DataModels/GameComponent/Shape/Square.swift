//
//  Square.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class Square: GameComponent {
    
    convenience init(location: CGPoint) {
        self.init(location: location, texture: SKTexture(imageNamed: "square"))
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: -30, y: 30), CGPoint(x: 30, y: 30), CGPoint(x:30, y: -30), CGPoint(x: -30, y: -30), CGPoint(x: -30, y: 30)])
        path.closeSubpath()
        self.physicsBody = SKPhysicsBody(polygonFrom: path)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = false
        }
        self.name = "Square"
    }
    

}

extension Square {
    override static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
}
