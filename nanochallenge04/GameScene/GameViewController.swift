//
//  GameViewController.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 04/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import SwiftUI
import SpriteKit
import GameplayKit


class GameViewController: UIViewController {
    
    var gameScene: GameScene!
    var gameDelegate: GameDelegate
    
    init(gameDelegate: GameDelegate) {
        self.gameDelegate = gameDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let sceneView = SKView(frame: view.frame)
        view.addSubview(sceneView)
        
        //        if let view = self.view as? SKView {
        // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            sceneView.presentScene(scene)
            self.gameScene = scene
            gameScene.gameDelegate = gameDelegate
        }
        sceneView.ignoresSiblingOrder = true
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        sceneView.preferredFramesPerSecond = 120
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
