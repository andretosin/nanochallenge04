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
    var spawner: Spawner!
    var collisionFlag = false
    var rollRate: CGFloat!
    
    var lastTime: TimeInterval = TimeInterval(0)
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        view.showsPhysics = true

        let playerNode = self.childNode(withName: "player") as! SKSpriteNode
        playerNode.zPosition = 1
        player = Player(scene: self, node: playerNode)
        
        let spawnerNode = self.childNode(withName: "spawner") as! SKSpriteNode
        spawner = Spawner(scene: self, node: spawnerNode)
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        player.update(CGFloat(deltaTime))
        spawner.update(CGFloat(deltaTime))
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

