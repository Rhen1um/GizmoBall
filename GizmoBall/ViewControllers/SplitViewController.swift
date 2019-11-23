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
    
    @IBOutlet var skView: SceneView!
    
    @IBAction func saveMenuItemClicked(_ sender: Any) {
        if let view = self.skView {
            guard let window = view.window else { return }
            
            let panel = NSSavePanel()
            panel.allowedFileTypes = ["gizmo"]
            
            panel.beginSheetModal(for: window) { (result) in
                if result == NSApplication.ModalResponse.OK {
                    if let view = self.skView {
                        self.saveScene(of: view, to: panel.url!)
                    }
                }
            }
        }
    }
    
    @IBAction func openDocument(_ sender: Any?) {
        guard let window = view.window else { return }
        
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        panel.allowedFileTypes = ["gizmo"]
        
        panel.beginSheetModal(for: window) { (result) in
            if result == NSApplication.ModalResponse.OK {
                let url = panel.urls[0]
                if let view = self.skView {
                    self.loadScene(from: url, presentTo: view)
                }
            }
        }
    }
    
    @IBAction func newDocument(_ sender: Any?) {
        if let view = self.skView {
            self.createNewScene(presentTo: view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.skView {
            //Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
    }
}

extension SplitViewController {
    // MARK: Scene Manager
    func loadScene(from url :URL, presentTo view: SceneView) {
        do{
            let sceneData = try Data(contentsOf: url)
            let scene = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [GameScene.self, SKCameraNode.self], from: sceneData) as! GameScene
            scene.scaleMode = .aspectFit
            view.presentScene(scene)
        } catch {
            print(error)
        }
    }
    
    func createNewScene(presentTo view: SceneView) {
        if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Present the scene
            view.presentScene(scene)
        }
    }
    
    func saveScene(of view: SceneView, to url: URL) {
        view.saveScene(to: url)
    }
}
