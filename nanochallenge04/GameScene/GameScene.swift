//
//  GameScene.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 04/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit

protocol GameDelegate {
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: Player!
    var background: GameBackground!
    var collisionFlag = false
    var rollRate: CGFloat!
    var rock: Rock!
    var stars: SKSpriteNode!
    var star: Star!
    var lastTime: TimeInterval = TimeInterval(0)
    var isPlayerDead: Bool = false
    let notification = UIImpactFeedbackGenerator(style: .heavy)
    var currentScore = 0
    var lblScore = SKLabelNode()
    var particles = SKEmitterNode()
    var gameStarted = false
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        view.showsPhysics = false
        
        if let particles = SKEmitterNode(fileNamed: "Stars") {
            particles.position = CGPoint(x: 0, y: 1200)
            particles.advanceSimulationTime(40)
            particles.zPosition = 0
            addChild(particles)
        }
        
        lblScore = self.childNode(withName: "lblScore") as! SKLabelNode
        lblScore.text = "\(currentScore)"
        
        
        let playerNode = self.childNode(withName: "player") as! SKSpriteNode
        playerNode.zPosition = 1
        player = Player(scene: self, node: playerNode)
        
        rock = Rock(scene: self)
        star = Star(scene: self)
        
        
        //        let starNode = self.childNode(withName: "star-1") as! SKSpriteNode
        //        starNode.zPosition = 1
        //        starNode.physicsBody = SKPhysicsBody(texture: starNode.texture!, size: starNode.texture!.size())
        //        starNode.physicsBody?.velocity = CGVector(dx: 0, dy: -200)
        
        
        
        
        
        
//        play()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        
        
        
        if gameStarted {
            player.update(CGFloat(deltaTime))
            rock.update(currentTime)
            star.update(currentTime)
        }
        
        
        //        if currentScore > 25 {
        //            star.speed = 3500
        //        }
        
        
    }
    
    // MARK: - ContactDelegate
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
        case ContactMask.player.rawValue | ContactMask.star.rawValue:
            for node in children {
                if node.name == "starTrue" {
                    if node.position.y < (player.node.position.y + player.node.size.height) && node.position.y > player.node.position.y {
                        node.name = "starResetPos"
                        notification.impactOccurred()
                        currentScore += 1
                        rock.speed += 75
                        star.speed += 75
                        particles.speed = star.speed
                        lblScore.text = "\(currentScore)"
                    }
                }
            }
        case ContactMask.player.rawValue | ContactMask.rock.rawValue:
            self.isPlayerDead = true
            star.isSpawnActive = false
            rock.isSpawnActive = false
        default:
            print("Unknown collision ocurred")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
    
    // MARK: - Swipe methods
    
    
    
    
    // MARK: - Touch methods
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted {
            if !isPlayerDead {
                for touch in touches {
                    let location = touch.location(in: self)
                    player.node.run(SKAction.moveTo(x: location.x, duration: 0.05))
                    rock.playerPosX = location.x
                }
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted {
            if !isPlayerDead {
                for touch in touches {
                    let location = touch.location(in: self)
                    player.node.run(SKAction.moveTo(x: location.x, duration: 0.05))
                    rock.playerPosX = location.x
                    
                }
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted {
            if !isPlayerDead {
                for touch in touches {
                    let location = touch.location(in: self)
                    player.node.run(SKAction.moveTo(x: location.x, duration: 0.05))
                    rock.playerPosX = location.x
                    
                }
            }
        }
    }
    
    func play() {
        gameStarted = true
    }
    
    func pause() {
        
    }
}

