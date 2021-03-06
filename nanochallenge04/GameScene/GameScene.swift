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
    func endRun(lastDistance: CGFloat, starsCollected: Int, totalStars: Int)
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var firstContactFlag: Bool = false
    var gameDelegate: GameDelegate?
    var background: GameBackground!
    var rock: Rock!
    var star: Star!
    var stars: SKSpriteNode!
    var totalStars: Int! = 0
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
    var audioPlayerAmbience: AVAudioPlayer!
    var audioPlayerPads: AVAudioPlayer!
    var lastTime: TimeInterval = TimeInterval(0)
    let notification = UIImpactFeedbackGenerator(style: .heavy)
    
    override func didMove(to view: SKView) {
        
        // se já existe um highscore e estrelas coletadas, carrega, se não, carrega 0
        let defaults = UserDefaults.standard
        let highscore = defaults.value(forKey: "highscore")
        let stars = defaults.value(forKey: "starsCollected") as? Int
        if highscore == nil {
            defaults.set(0, forKey: "highscore")
        }
        if stars == nil {
            defaults.set(0, forKey: "starsCollected")
        } else {
            totalStars = stars
        }
        
        self.physicsWorld.contactDelegate = self
        view.showsPhysics = false
        
        setAudioPlayers()
        
        // carrega particulas de fundo
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
        
        // carrega o nó do jogador vindo da gamescene.sks
        player = Player(scene: self)
        //        player.node.position = CGPoint(x: 0, y: -50)
        
        // carrega as estrelas e as pedras programaticamente
        rock = Rock(scene: self)
        star = Star(scene: self)
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
            rock.playerPosX = player.node.position.x
            
            
            if !isPlayerDead {
                self.flightIncrement = rock.speed
                self.flightDistance += flightIncrement
                self.lblDistance.text = "\(Int(flightDistance/20000))"
                self.lblDistance.alpha = 1
            }
            
        } else {
            self.player.node.position = CGPoint(x: 0, y: -50)
        }
    }
    
    // MARK: - ContactDelegate
    var lastHapticTimestamp: TimeInterval?
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
        case ContactMask.player.rawValue | ContactMask.star.rawValue:
            // se enconstou numa estrela
            
            
            for node in children {
                if node.name == "starTrue" {
                    if node.position.y < (player.node.position.y + player.node.size.height) && node.position.y > player.node.position.y {
                        node.name = "starResetPos"

                        print("--------")
                        DispatchQueue.global().async {
                            let now = Date().timeIntervalSince1970
                            defer { self.lastHapticTimestamp = now }
                            
                            if let last = self.lastHapticTimestamp {
                                let deltaTime = now - last
                                
                                print(deltaTime)
                                if deltaTime < 0.1 { return }
                            }
                            
                            
                            
                            self.notification.impactOccurred()
                        }
                        currentScore += 1
                        setSpeeds(rock.speed + 0)
                        lblScore.text = "\(currentScore)"
                    }
                }
            }
            
            
        case ContactMask.player.rawValue | ContactMask.rock.rawValue:
            // se encostou numa pedra
            if !firstContactFlag {
                firstContactFlag = true
                isPlayerDead = true
                star.isSpawnActive = false
                player.isDead = true
                rock.isSpawnActive = false
                audioPlayerAmbience.stop()
                totalStars += self.currentScore
                
                // salva a quantidade de moedas
                let defaults = UserDefaults.standard
                defaults.set(totalStars, forKey: "starsCollected")
                
                // pequeno delay após morrer para voltar par ao menu
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.endRun()
                }
            }
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
                    //                    player.node.run(SKAction.moveTo(x: location.x, duration: 0.05))
                    
                    
                    if location.x > 0 {
                        player.applyTorqueRight = true
                    } else {
                        player.applyTorqueLeft = true
                    }
                    player.isIdle = false
                    
                    
                    
                    
                }
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted {
            if !isPlayerDead {
                player.applyTorqueRight = false
                player.applyTorqueLeft = false
                player.isIdle = true
                
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func play(totalStars: Int) {
        gameStarted = true
        isPlayerDead = false
        self.totalStars = totalStars
        player.node.position = CGPoint(x: 0, y: -640)
        player.node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        firstContactFlag = false
        star.isSpawnActive = true
        rock.resetAllPos()
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
        player.xSpeed = speed
    }
    
    func endRun() {
        gameStarted = false
        gameDelegate?.endRun(lastDistance: self.flightDistance/20000, starsCollected: self.currentScore, totalStars: totalStars)
        player.node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        player.node.position = CGPoint(x: 0, y: 0)
        
    }
    
    func setAudioPlayers() {
        let sound = Bundle.main.path(forResource: "ambience", ofType: "wav")
        do {
            audioPlayerAmbience = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print("error")
        }
        
        let sound2 = Bundle.main.path(forResource: "pads", ofType: "wav")
        do {
            audioPlayerPads = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound2!))
        } catch {
            print("error")
        }
    }
    
    func playPad() {
        audioPlayerAmbience.play()
    }
    
    func stopPad() {
        audioPlayerAmbience.stop()
    }
    
    func playNoPad() {
        audioPlayerPads.play()
    }
    
    func stopNoPad() {
        audioPlayerPads.stop()
    }
    
    
}

