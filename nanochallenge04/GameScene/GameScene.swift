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
    func endRun(lastDistance: CGFloat, starsCollected: Int)
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gameDelegate: GameDelegate?
    var background: GameBackground!
    var rock: Rock!
    var star: Star!
    var stars: SKSpriteNode!
    var player: Player!
    var isPlayerDead: Bool = false
    var lblScore = SKLabelNode()
    var lblDistance = SKLabelNode()
    var particles = SKEmitterNode()
    var gameStarted = false
    var flightIncrement: CGFloat = 0
    var flightSpeed: CGFloat = 0
    var flightDistance: CGFloat = 0
    var currentScore = 0
    var audioPlayerPad: AVAudioPlayer!
    var audioPlayerNoPad: AVAudioPlayer!
    var lastTime: TimeInterval = TimeInterval(0)
    let notification = UIImpactFeedbackGenerator(style: .heavy)

    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        view.showsPhysics = false
        setAudioPlayers()
        
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
        
        
        player.node.position = CGPoint(x: 0, y: 0)
        
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
                self.flightIncrement = rock.speed
                self.flightDistance += flightIncrement
                self.lblDistance.text = "\(Int(flightDistance/20000))"
                self.lblDistance.alpha = 1
                rock.playerPosX = player.node.position.x
                print(self.flightIncrement)
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
                        setSpeeds(rock.speed + 75)
                        lblScore.text = "\(currentScore)"
                    }
                }
            }
        case ContactMask.player.rawValue | ContactMask.rock.rawValue:
            self.isPlayerDead = true
            self.player.node.physicsBody?.linearDamping = 0
            star.isSpawnActive = false
            rock.isSpawnActive = false
            audioPlayerPad.stop()
            endRun()
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
                    
//                    if location.x > 0 {
//                        player.accelerateRight = true
//                    } else {
//                        player.accelerateLeft = true
//                    }
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
                    
//                    player.accelerateRight = false
//                    player.accelerateLeft = false
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
                            

//                            player.node.run(SKAction.moveTo(x: location.x, duration: 0.05))
//                            rock.playerPosX = location.x
                        }
                    }
                }
    }
    
    func play() {
        gameStarted = true
        isPlayerDead = false
        player.node.position = CGPoint(x: 0, y: -640)
        player.node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        player.node.physicsBody?.applyTorque(500)
        star.isSpawnActive = true
        rock.isSpawnActive = true
        setSpeeds(1000)
        flightDistance = 0
        flightIncrement = 0
        currentScore = 0
        lblScore.text = "\(currentScore)"
        lblDistance.text = "\(flightDistance)"
        
    }
    
    func setSpeeds(_ speed: CGFloat) {
        particles.speed = speed
        rock.speed = speed
        star.speed = speed
    }
    
    func endRun() {
        gameStarted = false
        gameDelegate?.endRun(lastDistance: self.flightDistance/20000, starsCollected: self.currentScore)
        player.node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        player.node.position = CGPoint(x: 0, y: 0)
        
    }
    
    func setAudioPlayers() {
        let sound = Bundle.main.path(forResource: "nopad", ofType: "wav")
        do {
            audioPlayerPad = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print("error")
        }

        let sound2 = Bundle.main.path(forResource: "pad", ofType: "wav")
        do {
            audioPlayerNoPad = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound2!))
        } catch {
            print("error")
        }
    }
    
    func playPad() {
        audioPlayerPad.play()
    }
    
    func stopPad() {
        audioPlayerPad.stop()
    }
    
    func playNoPad() {
        audioPlayerNoPad.play()
    }
    
    func stopNoPad() {
        audioPlayerNoPad.stop()
    }
    
    
}

