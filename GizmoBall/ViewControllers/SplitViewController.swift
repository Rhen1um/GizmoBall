//
//  ViewController.swift
//  GizmoBall
//
//  Created by JJAYCHEN on 2019/11/21.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class SplitViewController: NSViewController, NSSplitViewDelegate {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
    }
    
    
//    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
//        return splitView.frame.width*0.75
//    }
//    
//    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
//        return splitView.frame.width*0.75
//    }
}

