//
//  Rock.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 12/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit


class Rock: Updatable {
    internal init(scene: SKScene?) {
        self.scene = scene
    }
    
    func update(_ deltaTime: CGFloat) {
        if deltaTime.truncatingRemainder(dividingBy: 2) > 1.99 {
            let node = SKSpriteNode(imageNamed: "Rock")
            node.physicsBody = SKPhysicsBody(texture: node.texture!, size: node.texture!.size())
            node.scale(to: CGSize(width: 100, height: 100))
            node.physicsBody?.affectedByGravity = false
            node.position.y = 1200
            node.position.x = CGFloat(Int.random(in: -400...200))
            node.physicsBody?.velocity = CGVector(dx: 0, dy: -2000)
            scene?.addChild(node)
        }
    }
    
    
    
    
    var node = SKSpriteNode(imageNamed: "Rock")
    var scene: SKScene?
    
    


    
    

}
