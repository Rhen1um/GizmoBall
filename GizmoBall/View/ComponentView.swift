//
//  ComponentView.swift
//  GizmoBall
//
//  Created by JJAYCHEN on 2019/11/21.
//  Copyright © 2019 Rhenium. All rights reserved.
//

import Cocoa

class ComponentView: NSImageView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
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
    
    func draggingSession(_ session: NSDraggingSession, endedAt screenPoint: NSPoint, operation: NSDragOperation) {
        let pastboard = session.draggingPasteboard
        if pastboard.string(forType: NSPasteboard.PasteboardType(rawValue: "result")) != nil {
            let identifier = actionToIdentifier[pastboard.string(forType: ComponentDrag.type)!]!
            print("放置\(identifier)成功")
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        if let componentType = self.identifier?.rawValue {
            let pasteboardItem = NSPasteboardItem()
            pasteboardItem.setString("Drag"+componentType+"Action", forType: ComponentDrag.type)
            
            let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
            draggingItem.setDraggingFrame(self.bounds, contents: self.image)
            
            beginDraggingSession(with: [draggingItem], event: event, source: self)
        }
        
    }
}
