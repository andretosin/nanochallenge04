//
//  Star.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 12/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class Star: Updatable {
    
    internal init(scene: SKScene?) {
        self.scene = scene
    }
    
    func update(_  currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        
    }
    var lastTime: TimeInterval = TimeInterval(0)
    var node = SKSpriteNode(imageNamed: "Rock")
    var scene: SKScene?
}
