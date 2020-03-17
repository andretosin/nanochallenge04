//
//  GameScene.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 04/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit
import AVFoundation

protocol GameDelegate {
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: Player!
    var background: GameBackground!
    var collisionFlag = false
    var rollRate: CGFloat!
    var rock: Rock!
    var star: Star!
    var stars: SKSpriteNode!
    var lastTime: TimeInterval = TimeInterval(0)
    var isPlayerDead: Bool = false
    let notification = UIImpactFeedbackGenerator(style: .heavy)
    var currentScore = 0
    var lblScore = SKLabelNode()
    var lblDistance = SKLabelNode()
    var particles = SKEmitterNode()
    var gameStarted = false
    var flightSpeed: CGFloat = 0
    var flightDistance: CGFloat = 0
    var audioPlayer: AVAudioPlayer!
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        view.showsPhysics = false
        
        
        
        let sound = Bundle.main.path(forResource: "nopad", ofType: "wav")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print("error")
        }
        
        
        
        
        
        if let particles = SKEmitterNode(fileNamed: "Stars") {
            particles.position = CGPoint(x: 0, y: 1200)
            particles.advanceSimulationTime(40)
            particles.zPosition = 0
            addChild(particles)
        }
        
        lblScore = self.childNode(withName: "lblScore") as! SKLabelNode
        lblScore.text = "\(currentScore)"
        
        lblDistance = self.childNode(withName: "lblDistance") as! SKLabelNode
        lblDistance.text = "\(flightDistance)"
        
        
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
            
            if !isPlayerDead {
                self.flightSpeed = rock.speed
                self.flightDistance += flightSpeed
                self.lblDistance.text = "\(Int(flightDistance/2000))"
                self.lblDistance.alpha = 1
            }
            
        }
        
        
        
        
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
            self.player.node.physicsBody?.linearDamping = 0
            star.isSpawnActive = false
            rock.isSpawnActive = false
            audioPlayer.stop()
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
                    if location.x > 0 {
                        player.accelerateRight = true
                    } else {
                        player.accelerateLeft = true
                    }
                }
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted {
            if !isPlayerDead {
                for touch in touches {
                    let location = touch.location(in: self)
                    
                    player.accelerateRight = false
                    player.accelerateLeft = false
                }
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        if gameStarted {
        //            if !isPlayerDead {
        //                for touch in touches {
        //                    let location = touch.location(in: self)
        //                    player.node.run(SKAction.moveTo(x: location.x, duration: 0.05))
        //                    rock.playerPosX = location.x
        //
        //                }
        //            }
        //        }
    }
    
    func play() {
        gameStarted = true
        audioPlayer.play()
    }
    
    func pause() {
        
    }
}

