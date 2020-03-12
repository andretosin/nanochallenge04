//
//  Spawner.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 12/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.

import SpriteKit


class rockSpawner: Updatable {
    
    func update(_ deltaTime: CGFloat) {

    }
    
    internal init(scene: GameScene?, node: SKSpriteNode?) {
        self.scene = scene
        self.node = node
    }
    
    
    var scene: GameScene!
    var node: SKSpriteNode!

}
