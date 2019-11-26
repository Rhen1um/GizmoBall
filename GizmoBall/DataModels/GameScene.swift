//
//  GameScene.swift
//  GizmoBall
//
//  Created by JJAYCHEN on 2019/11/22.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import SpriteKit
//import GameplayKit

struct PhysicsCategory {
    static let none : UInt32 = 0
    static let all: UInt32 = UINT32_MAX
    static let ball: UInt32 = 0b1
    static let absorber: UInt32 = 0b10
    static let track: UInt32 = 0b100
}


class GameScene: SKScene {
    private var _ball: Ball?
    private var selectedComponent: GameComponent?
    private var leftBar: LeftBar?
    private var rightBar: RightBar?
    
    
    var ball: Ball? {
        get {
            if _ball == nil {
                _ball = self.childNode(withName: "Ball") as? Ball
            }
            return _ball
        }
        set {
            _ball = newValue
        }
    }
    
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        drawTheGrid()
    }
    
    override func mouseDown(with event: NSEvent) {
        let point = event.location(in: self)
        let location = CGPoint(x: floor((point.x)/unit)*unit + 30, y: floor((point.y)/unit)*unit + 30)
        let ball = Ball(location: location)
        let square = Square(location: location)
        ball.zoomIn()
        ball.startPlay()
        self.addChild(ball)
        self.addChild(square)
    }
    
    override func mouseDragged(with event: NSEvent) {
        
    }
    
    
    override func keyDown(with event: NSEvent) {
        if (leftBar == nil){
            leftBar = self.childNode(withName: "LeftBar") as? LeftBar
        }
        if (rightBar == nil){
            rightBar = self.childNode(withName: "RightBar") as? RightBar
        }
        switch event.keyCode {
        case 0x7B:
            if let rightBar = self.rightBar {
                rightBar.moveLeft()
            }
        case 0x7C:
            if let rightBar = self.rightBar {
                rightBar.moveRight()
            }
        case 0x00:
            if let leftBar = self.leftBar {
                leftBar.moveLeft()
            }
        case 0x02:
            if let leftBar = self.leftBar {
                leftBar.moveRight()
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // MARK: Process for dragging
    
    public func add(DraggedComponent node: SKSpriteNode, at point: CGPoint) {
        node.position = point
        self.addChild(node)
    }
    
    
    public func drawTheGrid() {
        let width = self.size.width / 2;
        let height = self.size.height / 2;
        for x in stride(from: -width, to: width, by: unit){
            let myLine = SKShapeNode()
            let pathToDraw = CGMutablePath()
            pathToDraw.move(to: CGPoint(x: x, y: height))
            pathToDraw.addLine(to: CGPoint(x: x, y: -height))
            myLine.path = pathToDraw
            myLine.strokeColor = .gray
            self.addChild(myLine)
        }
        
        for y in stride(from: -height, to: height, by: unit){
            let myLine = SKShapeNode()
            let pathToDraw = CGMutablePath()
            pathToDraw.move(to: CGPoint(x: width , y: y))
            pathToDraw.addLine(to: CGPoint(x: -width, y: y))
            myLine.path = pathToDraw
            myLine.strokeColor = .gray
            self.addChild(myLine)
        }
    }
    
    public func enableBallGravity(){
//        if let physics = self.ball.physicsBody{
//            physics.affectedByGravity = true
//            physics.isDynamic = true
//            physics.allowsRotation = true
//        }
        self.ball?.startPlay()
    }
    
}

extension GameScene {
    override static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
}


