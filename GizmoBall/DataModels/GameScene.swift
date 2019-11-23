//
//  GameScene.swift
//  GizmoBall
//
//  Created by JJAYCHEN on 2019/11/22.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import SpriteKit
//import GameplayKit


class GameScene: SKScene {
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        drawTheGrid()
    }
    
    override func mouseDown(with event: NSEvent) {
        let point = event.location(in: self)
        let location = CGPoint(x: floor((point.x)/unit)*unit + 30, y: floor((point.y)/unit)*unit + 30)
        let ball = Circle(location: location)
        ball.zoomIn()
        ball.zoomIn()
        ball.nodeRotate()
        ball.zoomOut()
        self.addChild(ball)
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.childNode(withName: "shape")?.position = event.location(in: self)
    }
    
    
//    override func keyDown(with event: NSEvent) {
//        switch event.keyCode {
//        case 0x31:
//        default:
//            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
//        }
//    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // MARK: Process for dragging
    
    func add(DraggedComponent node: SKSpriteNode, at point: CGPoint) {
        node.position = point
        self.addChild(node)
    }
    
    
    func drawTheGrid() {
        let width = self.size.width / 2;
        let height = self.size.height / 2;
        for x in stride(from: -width, to: width, by: 60){
            let myLine = SKShapeNode()
            let pathToDraw = CGMutablePath()
            pathToDraw.move(to: CGPoint(x: x, y: height))
            pathToDraw.addLine(to: CGPoint(x: x, y: -height))
            myLine.path = pathToDraw
            myLine.strokeColor = .white
            self.addChild(myLine)
        }
        
        for y in stride(from: -height, to: height, by: 60){
            let myLine = SKShapeNode()
            let pathToDraw = CGMutablePath()
            pathToDraw.move(to: CGPoint(x: width , y: y))
            pathToDraw.addLine(to: CGPoint(x: -width, y: y))
            myLine.path = pathToDraw
            myLine.strokeColor = .white
            self.addChild(myLine)
        }
    }
}
