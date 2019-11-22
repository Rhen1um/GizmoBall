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
        
    }
    
    override func mouseDown(with event: NSEvent) {
        
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
}
