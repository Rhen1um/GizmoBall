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
    
}

