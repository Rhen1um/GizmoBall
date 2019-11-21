//
//  ComponentView.swift
//  GizmoBall
//
//  Created by JJAYCHEN on 2019/11/21.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import Cocoa

enum ComponentDrag {
    static let type = "Rhenium.GizmoBall.ComponentDrag"
    static let dragBallAction = "dragBallAction"
    static let dragTriangleAction = "dragTriangleAction"
    static let dragCircleAction = "dragCircleAction"
    //...
}

class ComponentView: NSImageView {
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
}

// MARK: - NSDraggingSource
extension ComponentView: NSDraggingSource {
    func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
        switch context {
        case .outsideApplication:
            return NSDragOperation()
        case .withinApplication:
            return .generic
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        if let componentType = self.identifier?.rawValue {
            let pasteboardItem = NSPasteboardItem()
            pasteboardItem.setString("Drag"+componentType+"Action", forType: NSPasteboard.PasteboardType(ComponentDrag.type))
            
            let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
            draggingItem.setDraggingFrame(self.bounds, contents: self.image)
            
            beginDraggingSession(with: [draggingItem], event: event, source: self)
        }
        
    }
}
