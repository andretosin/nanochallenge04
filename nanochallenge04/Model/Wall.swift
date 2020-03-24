//
//  GameBackground.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 10/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit
import UIKit

class Wall {
    internal init(scene: GameScene?, node: SKSpriteNode?) {
        self.scene = scene
        self.node = node
        self.configurePhysics()
    }
    
    var scene: GameScene!
    var node: SKSpriteNode!
    
    func configurePhysics() {
        node.physicsBody?.categoryBitMask = ContactMask.walls.rawValue
        node.physicsBody?.collisionBitMask = 0
    }
    
}
