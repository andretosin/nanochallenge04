//
//  GameScene.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 04/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: Player!
    var background: GameBackground!
    var collisionFlag = false
    var rollRate: CGFloat!
    var rock: Rock!
    var stars: SKSpriteNode!
    var lastTime: TimeInterval = TimeInterval(0)
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        view.showsPhysics = false

        let playerNode = self.childNode(withName: "player") as! SKSpriteNode
        playerNode.zPosition = 1
        player = Player(scene: self, node: playerNode)
        rock = Rock(scene: self)
        
        let starNode = self.childNode(withName: "star-1") as! SKSpriteNode
        starNode.zPosition = 1
        starNode.physicsBody = SKPhysicsBody(texture: starNode.texture!, size: starNode.texture!.size())
        starNode.physicsBody?.velocity = CGVector(dx: 0, dy: -200)
        
        
        
        
        
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
       
        
        player.update(currentTime)
        rock.update(currentTime)
        
        
        
        
        for node in children {
            if abs(node.position.y) > 1300 || abs(node.position.x) > 600 {
                node.removeFromParent()
            }
        }

        
        
        
        
        
        
    }
    
    // MARK: - ContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
    
    // MARK: - Swipe methods
    
    
    
    
    // MARK: - Touch methods
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            print(abs(player.node.position.x - location.x))
            player.node.run(SKAction.moveTo(x: location.x, duration: 0.05))
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            player.node.run(SKAction.moveTo(x: location.x, duration: 0.05))
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            player.node.run(SKAction.moveTo(x: location.x, duration: 0.05))
        }
    }
}

