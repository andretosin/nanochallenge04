//
//  Spawner.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 12/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.

import SpriteKit


class Spawner: Updatable {
    func update(_ deltaTime: CGFloat) {
        if deltaTime.truncatingRemainder(dividingBy: 2) > 1.9 {
            
            
        }
    }
    
    internal init(scene: GameScene?, node: SKSpriteNode?) {
        self.scene = scene
        self.node = node
    }
    
    func spawn() {
        
    }
    
    var scene: GameScene!
    var node: SKSpriteNode!
}
