//
//  GameComponent.swift
//  GizmoBall
//
//  Created by mufan on 2019/11/23.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import AppKit
import SpriteKit

class GameComponent: SKSpriteNode{
    var nodePosition = CGPoint(x: 0, y: 0)
    
    var defaultZPosition: CGFloat = 1
    
    convenience init(location: CGPoint, texture: SKTexture) {
        self.init(texture: texture)
        self.size = CGSize(width: unit, height: unit)
        self.xScale = 1
        self.yScale = 1
        self.position = location
        self.nodePosition = self.position
        

    }
    
    public func changePosition(newPoint: CGPoint) {
        self.position = newPoint
        self.nodePosition = self.position
    }
    
    public func changePositionOnPlay(newPoint: CGPoint) {
        self.position = newPoint
    }
    
    public func restore() {
        self.position = self.nodePosition
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
    }
    
    public func nodeRotate() {
        self.zRotation -= CGFloat(Double.pi / 2)
        print(self.zRotation)
    }
    
    public func zoomIn() -> Bool{
        if(self.xScale == 3) {
            return false
        }
        self.position = CGPoint(x: self.position.x + 30, y: self.position.y + 30)
        self.xScale += 1
        self.yScale += 1
        return true
    }
    
    public func zoomOut() -> Bool{
        if(self.xScale == 1) {
            return false
        }
        self.position = CGPoint(x: self.position.x - 30, y: self.position.y - 30)
        self.xScale -= 1
        self.yScale -= 1
        return true
    }
    

    
    func getNonTransparentSquaresIfPositioned(at point: CGPoint) -> [CGPoint]? {
        return getNonTransparentSquares(position: point, scale: self.xScale)
    }
    
    func getNonTransparentSquareIndexesIfPositioned(at point: CGPoint) -> Set<Int>? {
        if let squares = getNonTransparentSquares(position: point, scale: self.xScale) {
            var set: Set<Int> = Set<Int>()
            for r in squares {
                let index = floor(r.x/unit) + floor(r.y/unit)*16
                set.insert(Int(index))
            }
            return set
        }
        return nil
    }
    
    func getNonTransparentSquaresIfRotate() -> [CGPoint]?{
        return getNonTransparentSquares(position: self.position, scale: self.xScale)
    }
    
    func getNonTransparentSquaresIfZoomIn() -> [CGPoint]?{
        return getNonTransparentSquares(position: self.position, scale: self.xScale)
    }
    
    private func getNonTransparentSquares(position: CGPoint, scale: CGFloat) -> [CGPoint]? {
        if scale == 1 {
            return [CGPoint(x: position.x, y: position.y)]
        } else if scale == 2 {
            return [
                CGPoint(x: position.x + 0.5*unit, y: position.y + 0.5*unit),
                CGPoint(x: position.x + 0.5*unit, y: position.y - 0.5*unit),
                CGPoint(x: position.x - 0.5*unit, y: position.y + 0.5*unit),
                CGPoint(x: position.x - 0.5*unit, y: position.y - 0.5*unit),
            ]
        } else if scale == 3 {
            return [
                CGPoint(x: position.x, y: position.y),
                CGPoint(x: position.x, y: position.y + unit),
                CGPoint(x: position.x, y: position.y - unit),
                CGPoint(x: position.x + unit, y: position.y),
                CGPoint(x: position.x + unit, y: position.y + unit),
                CGPoint(x: position.x + unit, y: position.y - unit),
                CGPoint(x: position.x - unit, y: position.y),
                CGPoint(x: position.x - unit, y: position.y + unit),
                CGPoint(x: position.x - unit, y: position.y - unit),
            ]
        }
        
        return nil
    }
    
    public func makeAction(with ball: Ball) {
        
    }
}



