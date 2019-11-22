//
//  SceneView.swift
//  GizmoBall
//
//  Created by JJAYCHEN on 2019/11/21.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import Cocoa
import SpriteKit

let unit:CGFloat = 60.0

class SceneView: SKView {
    
    lazy var circle = SKSpriteNode.init(texture: SKTexture(imageNamed: "circle"), size: CGSize(width: unit, height: unit))
    lazy var triangle = SKSpriteNode.init(texture: SKTexture(imageNamed: "triangle"), size: CGSize(width: unit, height: unit))
    
    var actionComponentMap: [String: SKSpriteNode] = [:]
    
    let rect = SKShapeNode(rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: unit, height: unit)))
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
    // MARK: - NSDraggingDestination
    var acceptableTypes: Set<NSPasteboard.PasteboardType> { return [ComponentDrag.type]  }
    
    func setup() {
        registerForDraggedTypes(Array(acceptableTypes))
    }
    
    override func awakeFromNib() {
        setup()
        actionComponentMap["DragCircleAction"] = circle
        actionComponentMap["DragTriangleAction"] = triangle
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        // Got a reference to the dragging pasteboard from the dragging session info.
        let pasteBoard = sender.draggingPasteboard
        
        if let types = pasteBoard.types, acceptableTypes.intersection(types).count > 0 {
            self.scene!.addChild(rect)
            return .copy
        }
        
        return NSDragOperation()
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        
        let point = convert(sender.draggingLocation, to: self.scene!)
        let computedPoint = CGPoint(x:floor((point.x+unit/2)/unit)*unit-unit/2, y: floor((point.y+unit/2)/unit)*unit-unit/2)

        rect.position = computedPoint

        return .copy
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
         rect.removeFromParent()
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        rect.removeFromParent()
        
        let pasteBoard = sender.draggingPasteboard
        let scene = self.scene!
        let point = convert(sender.draggingLocation, to: scene)
        print(point)
        let computedPoint = CGPoint(x:floor((point.x+unit/2)/unit)*unit, y: floor((point.y+unit/2)/unit)*unit)
        print(computedPoint)
        
        if let types = pasteBoard.types, types.contains(ComponentDrag.type),
            let action = pasteBoard.string(forType: ComponentDrag.type) {
            let sprite = actionComponentMap[action]!
            let copied = sprite.copy() as! SKSpriteNode
            copied.position = computedPoint
            scene.addChild(copied)
            
            pasteBoard.setString("true", forType: NSPasteboard.PasteboardType(rawValue: "result"))
            
            return true
        }
        return false
    }
}
