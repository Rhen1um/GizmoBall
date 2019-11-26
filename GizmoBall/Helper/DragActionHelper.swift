//
//  DragActionHelper.swift
//  GizmoBall
//
//  Created by JJAYCHEN on 2019/11/26.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import Cocoa
import SpriteKit

enum ComponentDrag {
    static let type = NSPasteboard.PasteboardType("Rhenium.GizmoBall.ComponentDrag")
    static let dragBallAction = "DragBallAction"
    static let dragTriangleAction = "DragTriangleAction"
    static let dragCircleAction = "DragCircleAction"
    static let dragSquareAction = "DragSquareAction"
    static let dragAbsorberAction = "DragAbsorberAction"
    static let dragStraightTrackAction = "DragStraightTrackAction"
    static let dragCurvedTrackAction = "DragCurvedTrackAction"
    static let dragLeftBarAction = "DragLeftBarAction"
    static let dragRightBarAction = "DragRightBarAction"
}

let actionToIdentifier: [String: String] = [
    "DragBallAction": "Ball",
    "DragTriangleAction": "Triangle",
    "DragCircleAction": "Circle",
    "DragSquareAction": "Square",
    "DragAbsorberAction": "Absorber",
    "DragStraightTrackAction": "StraightTrack",
    "DragCurvedTrackAction": "CurvedTrack",
    "DragLeftBarAction": "LeftBar",
    "DragRightBarAction": "RightBar"
]

class ComponentFactory {
    var actionComponentMap: [String: SKSpriteNode] = [:]
    
    init() {
        let point: CGPoint = CGPoint(x: 0, y: 0)

        let ball = Ball(location: point)
        let triangle = Triangle(location: point)
        let circle = Circle(location: point)
        let square = Square(location: point)
        let absorber = Absorber(location: point)
        let straightTrack = StraightTrack(location: point)
        let curvedTrack = CurvedTrack(location: point)
        let leftBar = LeftBar(location: point)
        let rightBar = RightBar(location: point)
        
        actionComponentMap["DragCircleAction"] = circle
        actionComponentMap["DragTriangleAction"] = triangle
        actionComponentMap["DragBallAction"] = ball
        actionComponentMap["DragCircleAction"] = circle
        actionComponentMap["DragSquareAction"] = square
        actionComponentMap["DragAbsorberAction"] = absorber
        actionComponentMap["DragStraightTrackAction"] = straightTrack
        actionComponentMap["DragCurvedTrackAction"] = curvedTrack
        actionComponentMap["DragLeftBarAction"] = leftBar
        actionComponentMap["DragRightBarAction"] = rightBar
    }
}

// MARK: Helper functions
func convertToHintRectPosition(point: CGPoint) -> CGPoint {
    return CGPoint(x:floor((point.x)/unit)*unit, y: floor((point.y)/unit)*unit)
}

func convertToComponentDestinationPosition(point: CGPoint) -> CGPoint {
    return CGPoint(x:floor((point.x)/unit)*unit+unit/2, y: floor((point.y)/unit)*unit+unit/2)
}
