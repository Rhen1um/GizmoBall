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
        let curvedLine: SKShapeNode
        init() {
            splinePoints = [CGPoint(x: -30, y: 30),
                                CGPoint(x: -30, y: -30)]
            leftLine = SKShapeNode(splinePoints: &splinePoints,
                                     count: splinePoints.count)
            leftLine.lineWidth = 0
            leftLine.physicsBody = SKPhysicsBody(edgeChainFrom: leftLine.path!)
//            leftLine.physicsBody?.isDynamic = true
            
            splinePoints = [CGPoint(x: 30, y: 30),
                            CGPoint(x: 30, y: -30)]
            rightLine = SKShapeNode(splinePoints: &splinePoints,
                                    count: splinePoints.count)
            rightLine.lineWidth = 0
            rightLine.physicsBody = SKPhysicsBody(edgeChainFrom: rightLine.path!)
//            rightLine.physicsBody?.isDynamic = true
            
            splinePoints = [CGPoint(x: -30, y: 30),
                            CGPoint(x: 30, y: 30)]
            upLine = SKShapeNode(splinePoints: &splinePoints,
                                 count: splinePoints.count)
            upLine.lineWidth = 0
            upLine.physicsBody = SKPhysicsBody(edgeChainFrom: upLine.path!)
//            upLine.physicsBody?.isDynamic = true
            
            splinePoints = [CGPoint(x: -30, y: -30),
                            CGPoint(x: 30, y: -30)]
            downLine = SKShapeNode(splinePoints: &splinePoints,
                                   count: splinePoints.count)
            downLine.lineWidth = 0
            downLine.physicsBody = SKPhysicsBody(edgeChainFrom: downLine.path!)
//            downLine.physicsBody?.isDynamic = true
            
            splinePoints = [CGPoint(x: 30, y: 30),
                            CGPoint(x: 0, y: 22),
                            CGPoint(x: -12.43, y: 12.43),
                            CGPoint(x: -22, y: 0),
                            CGPoint(x: -30, y: -30)]
            curvedLine = SKShapeNode(splinePoints: &splinePoints,
                                   count: splinePoints.count)
            curvedLine.lineWidth = 0
            curvedLine.physicsBody = SKPhysicsBody(edgeChainFrom: curvedLine.path!)
//            downLine.physicsBody?.isDynamic = true
        }
        
        
        
    }
    override public func makeAction(with ball: Ball) {
        ball.changeGravity()
    }
    
}
