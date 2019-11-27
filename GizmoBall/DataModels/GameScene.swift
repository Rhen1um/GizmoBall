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
    static let none: UInt32 = 0
    static let all: UInt32 = UINT32_MAX
    static let ball: UInt32 = 0b1
    static let absorber: UInt32 = 0b10
    static let track : UInt32 = 0b100
}


class GameScene: SKScene {
    // Showed when user drags a component from the ToolBoxView
    let hintRect = SKShapeNode(rectOf: CGSize(width: unit, height: unit))
    
    private var isPlayMode: Bool = false
    
    private var _selectedComponent: GameComponent?
    
    private var selectedComponent: GameComponent? {
        get {
            return _selectedComponent
        }
        set {
            if let component = newValue {
                // 如果选中物体，移动选中提示框
                hintRect.isHidden = false
                hintRect.xScale = component.xScale
                hintRect.yScale = component.yScale
                hintRect.position = convertToHintRectPosition(point: component.position, size: component.xScale)
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
            if _ball == nil, let result = self.childNode(withName: "Ball") {
                _ball = result as? Ball
            }
            return _ball
        }
        set {
            _ball = newValue
        }
    }
    
    private var lastPosition: CGPoint?
    
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        isPlayMode = false
        drawTheGrid()
        // 注册选中提示框
        self.physicsWorld.contactDelegate = self
        if !self.children.contains(hintRect) {
            self.addChild(hintRect)
        } else {
            hintRect.removeFromParent()
            self.addChild(hintRect)
        }
        hintRect.strokeColor = .yellow
        hintRect.isHidden = true
    }
    
    override func mouseDown(with event: NSEvent) {
        if !isPlayMode {
            guard let selectedComponent = self.atPoint(event.location(in: self)) as? GameComponent else {
                // TODO: 重新开始游戏后，再次单击物体就会取消选中
                // 如果没选中，那么不显示选中提示框
                cancelSelection()
                return
            }
            self.selectedComponent = selectedComponent
            lastPosition = selectedComponent.position
        }
    }
    
    override func mouseDragged(with event: NSEvent) {
        if !isPlayMode {
            if let selectedComponent = self.selectedComponent {
                selectedComponent.position = event.location(in: self)
                hintRect.position = convertToHintRectPosition(point: selectedComponent.position, size: selectedComponent.xScale)
                
                if selectedComponent.name == "LeftBar" || selectedComponent.name == "RightBar" {
                    if selectedComponent.xScale == 2 {
                        hintRect.position = CGPoint(x: hintRect.position.x, y: hintRect.position.y - unit/2)
                    }
                }
            }
        }
    }
    
    override func mouseUp(with event: NSEvent) {
        if !isPlayMode {
            if let selectedComponent = self.selectedComponent {
                let point = event.location(in: self)
                
                // 如果拖拽的是三角形
                if let triangle = selectedComponent as? Triangle {
                    if let tmpPoints = triangle.getNonTransparentSquares() {
                        for tmpPoint in tmpPoints {
                            selectedComponent.zPosition = -1
                            let detectedNode = self.atPoint(tmpPoint)
                            selectedComponent.zPosition = 1
                            
                            if(detectedNode.name != nil) {
                                if let position = self.lastPosition {
                                    selectedComponent.changePosition(newPoint: position)
                                    hintRect.position = position
                                }
                                return
                            }
                        }
                    }
                }
                
                // 如果拖拽进了三角形
                selectedComponent.zPosition = -1
                let detectedNode = self.atPoint(point)
                selectedComponent.zPosition = 0
                if let triangle = detectedNode as? Triangle {
                    if !triangle.isTransparent(at: point) {
                        if let position = self.lastPosition {
                            selectedComponent.changePosition(newPoint: position)
                            hintRect.position = position
                        }
                        return
                    }
                }
                
                if detectedNode.name == nil || detectedNode.name == "Triangle" {
                    lastPosition = nil
                    selectedComponent.changePosition(newPoint: convertToComponentDestinationPosition(point: point, size: selectedComponent.xScale))
                    hintRect.position = convertToHintRectPosition(point: selectedComponent.position, size: selectedComponent.xScale)
                    if selectedComponent.name == "LeftBar" || selectedComponent.name == "RightBar" {
                        if selectedComponent.xScale == 2 {
                            selectedComponent.position = CGPoint(x: selectedComponent.position.x, y: selectedComponent.position.y - unit/2)
                            hintRect.position = CGPoint(x: hintRect.position.x, y: hintRect.position.y - unit/2)
                        }
                    }
                } else {
                    if let position = self.lastPosition {
                        selectedComponent.changePosition(newPoint: position)
                        hintRect.position = position
                    }
                }
            }
        }
    }
    
    override func keyDown(with event: NSEvent) {
        if isPlayMode {
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
            // added by JJAYCHEN. 保证线在最后一层
            myLine.zPosition = -1
            self.addChild(myLine)
        }
        
        for y in stride(from: -height, to: height, by: unit){
            let myLine = SKShapeNode()
            let pathToDraw = CGMutablePath()
            pathToDraw.move(to: CGPoint(x: width , y: y))
            pathToDraw.addLine(to: CGPoint(x: -width, y: y))
            myLine.path = pathToDraw
            myLine.strokeColor = .gray
            // added by JJAYCHEN. 保证线在最后一层
            myLine.zPosition = -1
            self.addChild(myLine)
        }
    }
    
    public func startPlay(){
        if let ball = self.ball {
            ball.enableGravity()
            isPlayMode = true
            cancelSelection()
        }
    }
    
    // MARK: Component Operations
    func rotateSelectedComponent() {
        if let selectedComponent = self.selectedComponent {
            if let triangle = selectedComponent as? Triangle {
                if let tmpPoints = triangle.getNonTransparentSquares(index: triangle.index + 1) {
                    for tmpPoint in tmpPoints {
                        selectedComponent.zPosition = -1
                        let detectedNode = self.atPoint(tmpPoint)
                        selectedComponent.zPosition = 1
                        
                        if(detectedNode.name != nil) {
                            if let position = self.lastPosition {
                                selectedComponent.changePosition(newPoint: position)
                                hintRect.position = position
                            }
                            return
                        }
                    }
                }
            }
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
            if selectedComponent.zoomOut() {
                if(selectedComponent.name == "LeftBar" || selectedComponent.name == "RightBar") {
                    HintRectHelper.zoomOutForBar(hintRect: hintRect)
                }
                else {
                    HintRectHelper.zoomOut(hintRect: hintRect)
                }
                //                selectedComponent.position = convertToComponentDestinationPosition(point: selectedComponent.position, size: selectedComponent.xScale)
                //                hintRect.position = convertToHintRectPosition(point: selectedComponent.position, size: selectedComponent.xScale)
            }
        }
    }
    
    func zoomInSelectedComponent() {
        if let selectedComponent = self.selectedComponent {
            if let triangle = selectedComponent as? Triangle {
                if let tmpPoints = triangle.getNonTransparentSquaresIfZoomIn() {
                    for tmpPoint in tmpPoints {
                        selectedComponent.zPosition = -1
                        let detectedNode = self.atPoint(tmpPoint)
                        selectedComponent.zPosition = 1
                        
                        if(detectedNode.name != nil) {
                            if let position = self.lastPosition {
                                selectedComponent.changePosition(newPoint: position)
                                hintRect.position = position
                            }
                            return
                        }
                    }
                }
            }
            
            if selectedComponent.zoomIn() {
                if(selectedComponent.name == "LeftBar" || selectedComponent.name == "RightBar") {
                    HintRectHelper.zoomInForBar(hintRect: hintRect)
                }
                else {
                    HintRectHelper.zoomIn(hintRect: hintRect)
                }
                //                selectedComponent.position = convertToComponentDestinationPosition(point: selectedComponent.position, size: selectedComponent.xScale)
                //                hintRect.position = convertToHintRectPosition(point: selectedComponent.position, size: selectedComponent.xScale)
            }
        }
        
    }
    
    func enterPlayMode() {
        startPlay()
    }
    
    func enterEditMode() {
        // TODO: Don't know how to implement
        isPlayMode = false
        ball?.restore()
    }
    
    func presentGameOverScene() {
        let reveal = SKTransition.flipVertical(withDuration: 0.5)
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
    public func add(DraggedComponent node: SKSpriteNode, at point: CGPoint) -> Bool{
        if !isPlayMode{
            let detectedNode = self.atPoint(point)
            if let triangle = detectedNode as? Triangle {
                if !triangle.isTransparent(at: point) {
                    return false
                }
            }
            
            if detectedNode.name == nil || detectedNode.name == "Triangle" {
                if node.name == "Ball" {
                    if (self.childNode(withName: "Ball") != nil) {
                        return false
                    }
                    node.zPosition = 1
                }
                if node.name == "LeftBar", (self.childNode(withName: "LeftBar") != nil) {
                    return false
                }
                if node.name == "RightBar", (self.childNode(withName: "RightBar") != nil) {
                    return false
                }
                if let node = node as? GameComponent {
                    node.changePosition(newPoint: point)
                }
                self.addChild(node)
                self.selectedComponent = node as? GameComponent
                
                return true
            }
        }
        return false
    }
    
    // MARK: Helper function for selectino
    func cancelSelection() {
        hintRect.isHidden = true
        self.selectedComponent = nil
    }
}

extension GameScene : SKPhysicsContactDelegate{
    // MARK: SKPhysicsContactDelegate
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
            if let ball = firstBody.node as? Ball{
                if let node = secondBody.node as? SKShapeNode{
                    ball.changeGravity()
                    print(ball.physicsBody?.affectedByGravity as Any)
                } else if let node = secondBody.node as? GameComponent{
                    node.makeAction(with: ball)
                    if node is Absorber {
                        self.presentGameOverScene()
                    }
                }
            }
        }
    }
}

