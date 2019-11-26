//
//  HintRect.swift
//  GizmoBall
//
//  Created by JJAYCHEN on 2019/11/26.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import SpriteKit

class HintRectHelper {
    static func zoomIn(hintRect: SKShapeNode) {
        if(hintRect.xScale == 3) {
            return
        }
        hintRect.position = CGPoint(x: hintRect.position.x + unit/2, y: hintRect.position.y + unit/2)
        hintRect.xScale += 1
        hintRect.yScale += 1
    }
    
    static func zoomOut(hintRect: SKShapeNode) {
        if(hintRect.xScale == 1) {
            return
        }
        hintRect.position = CGPoint(x: hintRect.position.x - unit/2, y: hintRect.position.y - unit/2)
        hintRect.xScale -= 1
        hintRect.yScale -= 1
    }
}
