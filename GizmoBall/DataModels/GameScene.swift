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
    static let all: UInt32 = UINT32_MAX
    static let ball: UInt32 = 0b1
    static let absorber: UInt32 = 0b10
    static let track : UInt32 = 0
}


class GameScene: SKScene {
    // Showed when user drags a component from the ToolBoxView
    let hintRect = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: unit, height: unit)))
    
    private var isPlayMode: Bool = false
    
    private var _selectedComponent: GameComponent?
    
    private var selectedComponent: GameComponent? {
        get {
            return _selectedComponent
        }
        set {
            if newValue != nil {
                // 如果选中物体，移动选中提示框
                hintRect.isHidden = false
                hintRect.setScale(newValue!.xScale)
//                hintRect.position = CGPoint(x: newValue!.position.x-unit/2, y: newValue!.position.y-unit/2)
            } else {
                hintRect.setScale(1)
                hintRect.isHidden = true
            }
            _selectedComponent = newValue
        }
    }
    
    private var leftBar: LeftBar?
    private var rightBar: RightBar?
    
    private var _ball: Ball?
    
    var ball: Ball? {
        get {
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
        self.physicsWorld.contactDelegate = self
        if !self.children.contains(hintRect) {
            self.addChild(hintRect)
        }
        hintRect.strokeColor = .yellow
        hintRect.isHidden = true
    }
    
    override func mouseDown(with event: NSEvent) {
        guard let selectedComponent = self.atPoint(event.location(in: self)) as? GameComponent else {
            // 如果没选中，那么不显示选中提示框
            hintRect.isHidden = true
            self.selectedComponent = nil
            return
        }
//        hintRect.position = selectedComponent.position
        self.selectedComponent = selectedComponent
    }
    
    override func mouseDragged(with event: NSEvent) {
        if let selectedComponent = self.selectedComponent {
            selectedComponent.position = event.location(in: self)
            hintRect.position = convertToHintRectPosition(point: event.location(in: self))
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        if let selectedComponent = self.selectedComponent {
            selectedComponent.position = convertToComponentDestinationPosition(point: event.location(in: self))
            hintRect.position = convertToHintRectPosition(point: event.location(in: self))
        }
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
    
    public func startPlay(){
        if let ball = self.ball {
            ball.enableGravity()
            isPlayMode = true
        }
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
        
        // added by JJAYCHEN
        self.selectedComponent = nil
    }
    
    func zoomOutSelectedComponent() {
        if let selectedComponent = self.selectedComponent {
            selectedComponent.zoomOut()
            HintRectHelper.zoomOut(hintRect: hintRect)
        }
    }
    
    func zoomInSelectedComponent() {
        if let selectedComponent = self.selectedComponent {
            selectedComponent.zoomIn()
            HintRectHelper.zoomIn(hintRect: hintRect)
        }
    }
    
    func enterPlayMode() {
        startPlay()
    }
    
    func enterEditMode() {
        // TODO: Don't know how to implement
        isPlayMode = false
    }
    
    func presentGameOverScene() {
        let reveal = SKTransition.flipVertical(withDuration: 0.5)
//        let message = "Game Over!"
//
//        let label = SKLabelNode(fontNamed: "Chalkduster")
//
//        label.text = message
//        label.fontSize = 80
//        label.fontColor = .white
//        label.position = CGPoint(x: 0, y: 0)
//
//        self.run(SKAction.sequence([
//            SKAction.run {
//                self.addChild(label)
//            },
//            SKAction.wait(forDuration: 1.5),
//            SKAction.run{
//                label.removeFromParent()
//            }
//            ]))
        let currentScene = self
        let gameoverScene = GameOverScene(size: self.size, scene: currentScene)
        self.view?.presentScene(gameoverScene, transition: reveal)
        ball?.restore()
        print("restore")
        leftBar?.restore()
        rightBar?.restore()
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
        if !isPlayMode {
            //            if let component = node as? GameComponent {
            //                component.
            //            }
            node.position = point
            self.addChild(node)
            self.selectedComponent = node as? GameComponent
        }
    }
}

extension GameScene : SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        print(contact.bodyB.categoryBitMask)
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
                if node is Absorber {
                    self.presentGameOverScene()
                }
            }
        }
    }
}

