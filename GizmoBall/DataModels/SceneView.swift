//
//  SceneView.swift
//  GizmoBall
//
//  Created by JJAYCHEN on 2019/11/21.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import Cocoa
import SpriteKit

class SceneView: SKView {
    
    var actionComponentMap: [String: SKSpriteNode] = ["dragBallAction": SKSpriteNode.init(imageNamed: "circle"),"dragTriangleAction": SKSpriteNode.init(imageNamed: "triangle"), "dragCircleAction": SKSpriteNode.init(imageNamed: "triangle")]
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
    // MARK: - NSDraggingDestination
    var acceptableTypes: Set<NSPasteboard.PasteboardType> { return [NSPasteboard.PasteboardType.init(ComponentDrag.type)]  }
    
    func setup() {
        registerForDraggedTypes(Array(acceptableTypes))
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        // Got a reference to the dragging pasteboard from the dragging session info.
        let pasteBoard = sender.draggingPasteboard
        
        if let types = pasteBoard.types, acceptableTypes.intersection(types).count > 0 {
            return .copy
        }
        
        return NSDragOperation()
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let pasteBoard = sender.draggingPasteboard
        
        //Convert the window-based coordinate to a view-relative coordinate.
//        let point = convert(sender.draggingLocation, from: nil)
        let point = convert(sender.draggingLocation, to: self.scene!)
//                let point = sender.draggingLocation
        
        if let types = pasteBoard.types, types.contains(NSPasteboard.PasteboardType(rawValue: ComponentDrag.type)),
            let action = pasteBoard.string(forType: NSPasteboard.PasteboardType(rawValue: ComponentDrag.type)) {
//            let sprite = actionComponentMap[action]!
//            let copied = sprite.copy() as! SKSpriteNode
            let copied = SKSpriteNode.init(imageNamed: "circle")
            copied.position = point
            self.scene?.addChild(copied)
            //          delegate?.processAction(action, center:point)
            //            print(point)
            return true
        }
        return false
    }
}
