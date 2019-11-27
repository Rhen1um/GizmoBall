//
//  Triangle.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class Triangle: GameComponent {
    private let vector = [CGPoint(x: -1, y: -1), CGPoint(x: -1, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: -1)]
    
    private var _index: Int = 0
    
    private var index: Int {
        get {
            return _index
        }
        set {
            _index = newValue % 4
        }
    }
    
    convenience init(location: CGPoint) {
        self.init(location: location, texture: SKTexture(imageNamed: "triangle"))
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: -30, y: 30), CGPoint(x: 30, y: -30), CGPoint(x: -30, y: -30), CGPoint(x: -30, y: 30)])
        path.closeSubpath()
        self.physicsBody = SKPhysicsBody(polygonFrom: path)
        if let physics = self.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = false
        }
        self.name = "Triangle"
    }
    
    override func nodeRotate() {
        super.nodeRotate()
        self.index = self.index + 1
    }
    
    private func getTransparentSquares() -> [CGPoint]? {
        if self.xScale == 2 {
            return [CGPoint(x: self.position.x - 0.5*unit*vector[index].x, y: self.position.y - 0.5*unit*vector[index].x)]
        } else if self.xScale == 3 {
            return [
                CGPoint(x: self.position.x - unit*vector[index].x, y: self.position.y - unit*vector[index].x),
                CGPoint(x: self.position.x, y: self.position.y - unit*vector[index].x),
                CGPoint(x: self.position.x - unit*vector[index].x, y: self.position.y),
            ]
        }
        return nil
    }
    
    func isTransparent(at point: CGPoint) -> Bool {
        if let points = getTransparentSquares() {
            for p in points {
                if point.x >= p.x - unit/2, point.x <= p.x + unit/2, point.x >= p.y - unit/2, point.x <= p.y + unit/2 {
                    return true
                }
            }
        }
        return false
    }
}
