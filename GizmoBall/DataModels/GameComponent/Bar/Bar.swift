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
    public func moveLeft() {
        self.changePositionOnPlay(newPoint: CGPoint(x: self.position.x - 30, y: self.position.y))
    }
    
    public func moveRight() {
        self.changePositionOnPlay(newPoint: CGPoint(x: self.position.x + 30, y: self.position.y))
    }
    
    override public func zoomIn() -> Bool{
        if(self.xScale == 3) {
            return false
        }
        self.position = CGPoint(x: self.position.x + 30, y: self.position.y)
        self.xScale += 1
        
        return true
    }
       
    override public func zoomOut() -> Bool{
        if(self.xScale == 1) {
            return false
        }
        self.position = CGPoint(x: self.position.x - 30, y: self.position.y)
        self.xScale -= 1
        return true
    }
    
    override func nodeRotate() {
        return
    }
    
    override func getNonTransparentSquaresIfZoomIn() -> [CGPoint]? {
        if self.xScale == 3 {
            return nil
        }
        let newPosition = CGPoint(x: self.position.x + 30, y: self.position.y)
        return getNonTransparentSquares(position: newPosition, scale: self.xScale + 1)
    }
    
    override func getNonTransparentSquaresIfPositioned(at point: CGPoint) -> [CGPoint]? {
           return getNonTransparentSquares(position: point, scale: self.xScale)
       }
    
    override func getNonTransparentSquareIndexesIfPositioned(at point: CGPoint) -> Set<Int>? {
        if let squares = getNonTransparentSquaresIfPositioned(at: point) {
            var set: Set<Int> = Set<Int>()
            for r in squares {
                let index = floor(r.x/unit) + floor(r.y/unit)*16
                set.insert(Int(index))
            }
            return set
        }
        return nil
    }
    
   
    func getNonTransparentSquares(position: CGPoint, scale: CGFloat) -> [CGPoint]? {
        if scale == 1 {
            return [CGPoint(x: position.x, y: position.y)]
        } else if scale == 2 {
            return [
                CGPoint(x: position.x + 0.5*unit, y: position.y),
                CGPoint(x: position.x - 0.5*unit, y: position.y)
            ]
        } else if scale == 3 {
            return [
                CGPoint(x: position.x + unit, y: position.y),
                CGPoint(x: position.x - unit, y: position.y),
                CGPoint(x: position.x, y: position.y)
            ]
        }
        
        return nil
    }
    
}

