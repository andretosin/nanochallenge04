//
//  GameBackground.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 10/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit
import UIKit

class GameBackground: Updatable {
    internal init(scene: GameScene?, node: SKSpriteNode?) {
        self.scene = scene
        self.node = node
        self.configurePhysics()
    }    
    
    var scene: GameScene!
    var node: SKSpriteNode!
    
    
    func configurePhysics() {
        self.node.physicsBody?.contactTestBitMask = 0
        self.node.physicsBody?.categoryBitMask = ContactMask.walls.rawValue
        self.node.physicsBody?.collisionBitMask = ContactMask.player.rawValue
    }
    
    func update(_ deltaTime: CGFloat) {
        self.node.position.y -= 25
    }
    
    
}
