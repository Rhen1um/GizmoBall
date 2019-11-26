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
    // Showed when user drags a component from the ToolBoxView
    let hintRect = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: unit, height: unit)))
    
    private var _selectedComponent: GameComponent?
    
    private var selectedComponent: GameComponent? {
        get {
            return _selectedComponent
        }
        set {
            // 如果选中物体，移动选中提示框
            hintRect.isHidden = false
            hintRect.position = CGPoint(x: newValue!.position.x-unit/2, y: newValue!.position.y-unit/2)
            _selectedComponent = newValue
        }
    }
    
    private var leftBar: LeftBar?
    private var rightBar: RightBar?
    
    private var _ball: Ball?
    
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
        // 注册选中提示框
        self.addChild(hintRect)
        hintRect.strokeColor = .yellow
        hintRect.isHidden = true
    }
    
    override func mouseDown(with event: NSEvent) {
        guard let selectedComponent = self.atPoint(event.location(in: self)) as? GameComponent else {
            // 如果没选中，那么不显示选中提示框
            hintRect.isHidden = true
            return
        }
        self.selectedComponent = selectedComponent
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
    
    // MARK: Component Operations
    func rotateSelectedComponent() {
        if let selectedComponent = self.selectedComponent {
            selectedComponent.nodeRotate()
        }
    }
    
    func removeSelectedComponent() {
        if let selectedComponent = self.selectedComponent,
            let name = self.selectedComponent?.name {
            selectedComponent.removeFromParent()
            if name == "Ball" {
                self.ball = nil
            } else if name == "LeftBar" {
                self.leftBar = nil
            } else if name == "RightBar" {
                self.rightBar = nil
            }
        }
    }
    
}

extension GameScene {
    // MARK: configuration for saving
    override static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    // MARK: Process for dragging
    public func add(DraggedComponent node: SKSpriteNode, at point: CGPoint) {
        node.position = point
        self.addChild(node)
    }
}

extension GameScene : SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & PhysicsCategory.ball) != 0 {
            if let node = secondBody.node as? GameComponent,
                let ball = firstBody.node as? Ball{
                node.makeAction(with: ball)
            }
        }
    }
}

