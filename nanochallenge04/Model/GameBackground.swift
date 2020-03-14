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
    
    func update(_ deltaTime: CGFloat) {

        
        
        self.node.position.y -= 0
        print(self.node.position.y)
        if self.node.position.y < -1000 {
            self.node.position.y = 0
        }
    }
    
    internal init(scene: GameScene?, node: SKSpriteNode?) {
        self.scene = scene
        self.node = node
    }    
    
    var scene: GameScene!
    var node: SKSpriteNode!
    var lastTime: TimeInterval = TimeInterval(0)
}
