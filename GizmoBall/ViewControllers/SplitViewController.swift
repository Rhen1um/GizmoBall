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
    
    var scene: SKScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNewScene(presentTo: skView)
    }
    
    // MARK: Button Actions
    @IBAction func rotateButtonClicked(_ sender: Any) {
        if let scene = self.scene as? GameScene {
            scene.rotateSelectedComponent()
        }
    }
    @IBAction func removeButtonClicked(_ sender: Any) {
        if let scene = self.scene as? GameScene {
            scene.removeSelectedComponent()
        }
    }
    
    @IBAction func zoomOutButtonClicked(_ sender: Any) {
        if let scene = self.scene as? GameScene {
            scene.zoomOutSelectedComponent()
        }
    }
    
    @IBAction func zoomInButtonClicked(_ sender: Any) {
        if let scene = self.scene as? GameScene {
            scene.zoomInSelectedComponent()
        }
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        if let scene = self.scene as? GameScene {
            scene.enterPlayMode()
        }
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        if let scene = self.scene as? GameScene {
            scene.enterEditMode()
        }
    }
}

extension SplitViewController {
    // MARK: Create & Save & Load Scene
    
    @IBAction func saveDocument(_ sender: Any) {
        if let view = self.skView, let scene = self.scene {
            guard let window = view.window else { return }
            
            let panel = NSSavePanel()
            panel.allowedFileTypes = ["gizmo"]
            
            panel.beginSheetModal(for: window) { (result) in
                if result == NSApplication.ModalResponse.OK {
                    self.save(scene: scene, of: view, to: panel.url!)
                }
            }
        }
    }
    
    @IBAction func openDocument(_ sender: Any?) {
        if let view = self.skView {
            guard let window = view.window else { return }
            
            let panel = NSOpenPanel()
            panel.canChooseFiles = true
            panel.canChooseDirectories = false
            panel.allowsMultipleSelection = false
            panel.allowedFileTypes = ["gizmo"]
            
            panel.beginSheetModal(for: window) { (result) in
                if result == NSApplication.ModalResponse.OK {
                    let url = panel.urls[0]
                    self.load(scene: self.scene, from: url, presentTo: view)
                }
            }
            
        }
    }
    
    @IBAction func newDocument(_ sender: Any?) {
        if let view = self.skView {
            self.createNewScene(presentTo: view)
        }
    }
    
    func createNewScene(presentTo view: SceneView) {
        if let view = skView , let scene = SKScene(fileNamed: "GameScene") {
            
            scene.scaleMode = .aspectFill
            
            view.presentScene(scene)
            
            self.scene = scene
        }
    }
    
    func load(scene: SKScene?, from url :URL, presentTo view: SceneView) {
        do{
            let sceneData = try Data(contentsOf: url)
            let scene = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [GameScene.self, SKCameraNode.self], from: sceneData) as! GameScene
            scene.scaleMode = .aspectFit
            view.presentScene(scene)
            
            self.scene = scene
        } catch {
            print(error)
        }
    }
    
    func save(scene: SKScene?, of view: SceneView, to url: URL) {
        if let scene = self.scene {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: scene, requiringSecureCoding: false)
                try data.write(to: url)
            } catch {
                print(error)
            }
        }
    }
}
