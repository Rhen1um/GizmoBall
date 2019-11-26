//
//  GameOverScene.swift
//  GizmoBall
//
//  Created by 童翰文 on 2019/11/26.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    init(size: CGSize , scene: GameScene) {
        super.init(size: size)
        
        self.backgroundColor = .darkGray
        
        let message = "Game Over!"
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        
        label.text = message
        label.fontSize = 80
        label.fontColor = .white
        label.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(label)
        
        
        self.run(SKAction.sequence([
                SKAction.wait(forDuration: 2.0),
                SKAction.run {[weak self] in
                    guard let `self` = self else {
                        return
                    }
                    let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                    self.view?.presentScene(scene, transition: reveal)
                }
            ]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
