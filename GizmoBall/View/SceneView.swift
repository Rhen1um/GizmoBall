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
    // MARK: Initial setup
    var actionComponentMap: [String: SKSpriteNode] = ComponentFactory().actionComponentMap
    
    // Showed when user drags a component from the ToolBoxView
    var hintRect:SKShapeNode {
        get {
            let scene = self.scene as! GameScene
            scene.hintRect.isHidden = false
            return scene.hintRect
        }
    }
    
    // Default method. Do no care about it
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    // MARK: - NSDraggingDestination
    
    // Declare the accepatable types. Here we solely accept ComponentDrag.type
    var acceptableTypes: Set<NSPasteboard.PasteboardType> { return [ComponentDrag.type]  }
    
    // Do some setup work such as resigter for dragged type and initialize the actionComponentMap.
    // Called in awakeFromNib()
    func setup() {
        registerForDraggedTypes(Array(acceptableTypes))
    }
    
    // Accept the dragging and show the hintRect
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        // Got a reference to the dragging pasteboard from the dragging session info.
        let pasteBoard = sender.draggingPasteboard
        
        if let types = pasteBoard.types, acceptableTypes.intersection(types).count > 0 {
//            self.scene!.addChild(hintRect)
            return .copy
        }
        
        return NSDragOperation()
    }
    
    // Update the position of hintRect
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        if let scene = self.scene {
            let point = convert(sender.draggingLocation, to: scene)
            hintRect.position = convertToHintRectPosition(point: point)
            return .copy
        }
        return NSDragOperation()
    }
    
    // Remove the hintRect from scene
    override func draggingExited(_ sender: NSDraggingInfo?) {
//        hintRect.removeFromParent()
        hintRect.isHidden = true
    }
    
    // Add the specified component and remove the hintRect
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
//        hintRect.removeFromParent()
        hintRect.isHidden = true
        if let scene = self.scene as? GameScene {
            let pasteBoard = sender.draggingPasteboard
            
            if let types = pasteBoard.types, types.contains(ComponentDrag.type),
                let action = pasteBoard.string(forType: ComponentDrag.type) {
                
                if let sprite = actionComponentMap[action] {
                    let copied = sprite.copy() as! SKSpriteNode
                    
                    let point = convert(sender.draggingLocation, to: scene)
                    let componentDestinationPoint = convertToComponentDestinationPosition(point: point)
                    
                    scene.add(DraggedComponent: copied, at: componentDestinationPoint)
                    // TODO: 如果是 Ball, 设置一下 scene 的 ball 属性.
                    
                    let identifier = actionToIdentifier[action]!
                    if(identifier == "Ball") {
                        scene.ball = copied as? Ball
                    }
                    
                    pasteBoard.setString("true", forType: NSPasteboard.PasteboardType(rawValue: "result"))
                }
                
                return true
            }
        }
        return false
    }
}
