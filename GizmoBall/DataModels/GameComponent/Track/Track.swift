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
    var lineNodes: LineNodes?
    
    class LineNodes {
        var splinePoints: [ CGPoint]
        let leftLine: SKShapeNode
        let rightLine: SKShapeNode
        let upLine: SKShapeNode
        let downLine: SKShapeNode
        init() {
            splinePoints = [CGPoint(x: -30, y: 30),
                                CGPoint(x: -30, y: -30)]
            leftLine = SKShapeNode(splinePoints: &splinePoints,
                                     count: splinePoints.count)
            leftLine.lineWidth = 5
            leftLine.physicsBody = SKPhysicsBody(edgeChainFrom: leftLine.path!)
            
            splinePoints = [CGPoint(x: 30, y: 30),
                            CGPoint(x: 30, y: -30)]
            rightLine = SKShapeNode(splinePoints: &splinePoints,
                                    count: splinePoints.count)
            rightLine.lineWidth = 5
            rightLine.physicsBody = SKPhysicsBody(edgeChainFrom: rightLine.path!)
            
            splinePoints = [CGPoint(x: -30, y: 30),
                            CGPoint(x: 30, y: 30)]
            upLine = SKShapeNode(splinePoints: &splinePoints,
                                 count: splinePoints.count)
            upLine.lineWidth = 5
            upLine.physicsBody = SKPhysicsBody(edgeChainFrom: upLine.path!)
            
            splinePoints = [CGPoint(x: -30, y: -30),
                            CGPoint(x: 30, y: -30)]
            downLine = SKShapeNode(splinePoints: &splinePoints,
                                   count: splinePoints.count)
            downLine.lineWidth = 5
            downLine.physicsBody = SKPhysicsBody(edgeChainFrom: downLine.path!)
        }
        
        
        
    }
    override public func makeAction(with ball: Ball) {
        ball.changeGravity()
    }
    
}
