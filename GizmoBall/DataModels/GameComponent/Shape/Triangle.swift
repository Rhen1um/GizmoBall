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
    
    public var index: Int {
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
    
    func getTransparentSquares() -> [CGPoint]? {
        return getTransparentSquares(index: self.index)
    }
    
    private func getTransparentSquares(index: Int) -> [CGPoint]? {
        if self.xScale == 2 {
            return [CGPoint(x: self.position.x - 0.5*unit*vector[index].x, y: self.position.y - 0.5*unit*vector[index].y)]
        } else if self.xScale == 3 {
            return [
                CGPoint(x: self.position.x - unit*vector[index].x, y: self.position.y - unit*vector[index].y),
                CGPoint(x: self.position.x, y: self.position.y - unit*vector[index].y),
                CGPoint(x: self.position.x - unit*vector[index].x, y: self.position.y),
            ]
        }
        return nil
    }
    
    func getNonTransparentSquaresIfZoomIn() -> [CGPoint]? {
        if self.xScale == 3 {
            return nil
        }
        let newPosition = CGPoint(x: self.position.x + 30, y: self.position.y + 30)
        return getNonTransparentSquares(position: newPosition, index: index, scale: self.xScale + 1)
    }
    
    func getNonTransparentSquaresIfPositioned(at point: CGPoint) -> [CGPoint]? {
        return getNonTransparentSquares(position: point, index: self.index, scale: self.xScale)
    }
    
    func getNonTransparentSquares() -> [CGPoint]? {
        return getNonTransparentSquares(index: self.index)
    }
    
    func getNonTransparentSquares(index: Int) -> [CGPoint]? {
        return getNonTransparentSquares(position: self.position, index: index, scale: self.xScale)
    }
    
    func getNonTransparentSquares(position: CGPoint, index: Int, scale: CGFloat) -> [CGPoint]? {
        if scale == 2 {
            return [
                CGPoint(x: position.x + 0.5*unit*vector[index].x, y: position.y + 0.5*unit*vector[index].y),
                CGPoint(x: position.x + 0.5*unit*vector[index].x, y: position.y - 0.5*unit*vector[index].y),
                CGPoint(x: position.x - 0.5*unit*vector[index].x, y: position.y + 0.5*unit*vector[index].y),
            ]
        } else if scale == 3 {
            return [
                CGPoint(x: position.x, y: position.y),
                CGPoint(x: position.x + unit*vector[index].x, y: position.y),
                CGPoint(x: position.x + unit*vector[index].x, y: position.y - unit*vector[index].y),
                CGPoint(x: position.x, y: position.y + unit*vector[index].y),
                CGPoint(x: position.x - unit*vector[index].x, y: position.y + unit*vector[index].y),
                CGPoint(x: position.x + unit*vector[index].x, y: position.y - unit*vector[index].y),
            ]
        }
        return nil
    }
    
    func isTransparent(at point: CGPoint) -> Bool {
        if let points = getTransparentSquares() {
            for p in points {
                if point.x >= p.x - unit/2, point.x <= p.x + unit/2, point.y >= p.y - unit/2, point.y <= p.y + unit/2 {
                    return true
                }
            }
        }
        return false
    }
}

extension Triangle {
    override static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
}
