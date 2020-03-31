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
    func updateLabels(flightDistance: String, currentScore: String)
    func updateSlices(slices: Int)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var firstContactFlagPlayerRock: Bool = false
    var firstContactFlagPlayerOrange: Bool = false
    var gameDelegate: GameDelegate?
    var background: GameBackground!
    var rock: Rock!
    var star: Star!
    var orange: Orange!
    var player: Player!
    var powerup: PowerUp!
    var meteor: Meteor!
    var totalStars: Int! = 0
    var isPlayerDead: Bool = false
    var isSoundMuted: Bool = false
    var particles = SKEmitterNode()
    var gameStarted = false
    var flightIncrement: CGFloat = 0
    var flightSpeed: CGFloat = 1000 {
        didSet {
            setSpeeds(self.flightSpeed)
        }
    }
    var flightDistance: CGFloat = 0
    var currentScore = 0
    var audioPlayerAmbience: AVAudioPlayer!
    var audioPlayerPads: AVAudioPlayer!
    var lastTime: TimeInterval = TimeInterval(0)
    let notification = UIImpactFeedbackGenerator(style: .heavy)
    var isBoostActive = false {
        didSet {
            if isBoostActive {
                flightSpeed = 3000
                flightSlowdown = 2.0
                rock.isSpawnActive = false
                orange.isSpawnActive = false
                powerup.isSpawnActive = false
                meteor.isSpawnActive = false
                player.b1.toggle()
            } else {
                flightSlowdown = 0.2
                rock.isSpawnActive = true
                orange.isSpawnActive = true
                powerup.isSpawnActive = true
                meteor.isSpawnActive = true
            }
        }
    }
    
    
    
    
    var slices = 0
    var flightSlowdown: CGFloat = 0.2
    
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
        view.showsPhysics = true
        
        setAudioPlayers()
        
        // carrega particulas de fundo
        particles = SKEmitterNode(fileNamed: "Stars")!
        particles.position = CGPoint(x: 0, y: 1200)
        particles.advanceSimulationTime(40)
        particles.zPosition = 0
        particles.particleSpeed = 1000
        addChild(particles)
        
        // carrega o nó do jogador vindo da gamescene.sks
        player = Player(scene: self)
        //        player.node.position = CGPoint(x: 0, y: -50)
        
        // carrega as estrelas e as pedras programaticamente
        rock = Rock(scene: self)
        star = Star(scene: self)
        orange = Orange(scene: self, resetFlag: {
            self.firstContactFlagPlayerOrange = false
        })
        powerup = PowerUp(scene: self)
        meteor = Meteor(scene: self)
        
        audioPlayerPads.play()
        audioPlayerAmbience.play()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        
        if flightSpeed > 1000 {
            if flightSpeed > 1200 {
                if flightSpeed > 1400 {
                    if flightSpeed > 1600 {
                        if flightSpeed > 1800 {
                            if flightSpeed >= 2000 {
                                gameDelegate?.updateSlices(slices: 6)
                                //                                print("level 6")
                                star.normalChance = 0
                            } else {
                                gameDelegate?.updateSlices(slices: 5)

                                if !isBoostActive {
                                    print("level 5")
                                    rock.spawnChance = 40
                                    meteor.spawnChance = 50
                                    orange.singleChance = 35
                                    orange.doubleChance = 70
                                    orange.tripleChance = 100
                                }
                            }
                        } else {
                            gameDelegate?.updateSlices(slices: 4)

                            if !isBoostActive {
                                //                            print("level 4")
                                rock.spawnChance = 50
                                meteor.spawnChance = 60
                                orange.singleChance = 40
                                orange.doubleChance = 80
                                orange.tripleChance = 100
                                star.spawnChance = 100
                                star.normalChance = 80
                            }
                        }
                    } else {
                        gameDelegate?.updateSlices(slices: 3)

                        if !isBoostActive {
                            //                        print("level 3")
                            rock.spawnChance = 60
                            meteor.spawnChance = 70
                            star.spawnChance = 70
                            star.normalChance = 100
                            orange.singleChance = 45
                            orange.doubleChance = 90
                            orange.tripleChance = 10
                        }
                    }
                } else {
                    gameDelegate?.updateSlices(slices: 2)

                    if !isBoostActive {
                        //                    print("level 2")
                        rock.spawnChance = 80
                        meteor.spawnChance = 80
                        star.isSpawnActive = true
                        star.normalChance = 100
                        orange.singleChance = 60
                        orange.doubleChance = 90
                        orange.tripleChance = 100
                    }
                }
            } else {
                gameDelegate?.updateSlices(slices: 1)

                if !isBoostActive {
                    //                print("level 1")
                    rock.spawnChance = 90
                    meteor.spawnChance = 90
                    star.isSpawnActive = false
                    orange.singleChance = 80
                    orange.doubleChance = 95
                    orange.tripleChance = 100
                }
            }
        } else {
            gameDelegate?.updateSlices(slices: 0)

            isBoostActive = false
            //            print("level 0")
            rock.spawnChance = 100
            meteor.spawnChance = 100
            star.spawnChance = 90
            star.normalChance = 50
            orange.singleChance = 100
            orange.doubleChance = 0
            orange.tripleChance = 0
        }
        
        if gameStarted {
            player.update(CGFloat(deltaTime))
            rock.update(currentTime)
            star.update(currentTime)
            meteor.update(currentTime)
            orange.update(currentTime)
            //            powerup.update(currentTime)
            meteor.playerPosX = player.node.position.x
            
            if self.flightSpeed > 1000 {
                self.flightSpeed -= flightSlowdown
            }
            
            if !player.isDead {
                self.flightIncrement = rock.speed
                self.flightDistance += flightIncrement
                
                gameDelegate?.updateLabels(flightDistance: "\(Int(flightDistance/20000))", currentScore: String(self.currentScore))
                
            }
        } else {
            self.player.node.position = CGPoint(x: 0, y: -50)
        }
    }
    
    
    
    // MARK: - ContactDelegate
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask {
        case ContactMask.player.rawValue | ContactMask.starNormal.rawValue:
            // se enconstou numa estrela normal
            for node in children {
                if node.name == "starNormalTrue" {
                    if node.position.y < (player.node.position.y + player.node.size.height) && node.position.y > player.node.position.y {
                        node.name = "starNormalResetPos"
                        notification.impactOccurred()
                        currentScore += 1
                    }
                }
            }
        case ContactMask.player.rawValue | ContactMask.starDouble.rawValue:
            // se enconstou numa estrela double
            for node in children {
                if node.name == "starDoubleTrue" {
                    if node.position.y < (player.node.position.y + player.node.size.height) && node.position.y > player.node.position.y {
                        node.name = "starDoubleResetPos"
                        notification.impactOccurred()
                        currentScore += 2
                    }
                }
            }
        case ContactMask.player.rawValue | ContactMask.orangeSingle.rawValue:
            // se encosotu numa laranja
            if !firstContactFlagPlayerOrange {

                firstContactFlagPlayerOrange = true
                self.flightSpeed += 200
                if self.flightSpeed > 2000 {
                    isBoostActive = true
                }
                if self.flightSpeed > 2200 {
                    self.flightSpeed = 2200
                }
            }
            case ContactMask.player.rawValue | ContactMask.orangeDouble.rawValue:
            // se encosotu numa laranja

            if !firstContactFlagPlayerOrange {

                firstContactFlagPlayerOrange = true
                self.flightSpeed += 300
                if self.flightSpeed > 2000 {
                    isBoostActive = true
                }
                if self.flightSpeed > 2200 {
                    self.flightSpeed = 2200
                }
            }

            case ContactMask.player.rawValue | ContactMask.orangeTriple.rawValue:
            // se encosotu numa laranja

            if !firstContactFlagPlayerOrange {

                firstContactFlagPlayerOrange = true
                self.flightSpeed += 400
                if self.flightSpeed > 2000 {
                    isBoostActive = true
                }
                if self.flightSpeed > 2200 {
                    self.flightSpeed = 2200
                }
            }

            

            
            
        case ContactMask.player.rawValue | ContactMask.rock.rawValue:
            // se encostou numa pedra
            if !firstContactFlagPlayerRock {
                firstContactFlagPlayerRock = true
                player.isDead = true
                star.isSpawnActive = false
                rock.isSpawnActive = false
                orange.isSpawnActive = false
                player.isDead = true
                //                player.node.physicsBody?.allowsRotation = false
                totalStars += self.currentScore
                
                player.node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                
                // salva a quantidade de moedas
                let defaults = UserDefaults.standard
                defaults.set(totalStars, forKey: "starsCollected")
                
                // pequeno delay após morrer para voltar par ao menu
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.endRun()
                }
            }
            
        case ContactMask.watermelon.rawValue | ContactMask.player.rawValue:
            // se encostou numa melancia
            print("encostou na melancia")
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
            if !player.isDead {
                for touch in touches {
                    let location = touch.location(in: self)
                    //                    player.node.run(SKAction.moveTo(x: location.x, duration: 0.05))
                    
                    
                    
                    
                    if location.x > 0 {
                        player.applyTorqueRight = true
                        
                    } else {
                        player.applyTorqueLeft = true
                    }
                    player.isIdle = false
                    
                    
                    
                    //                    rock.playerPosX = location.x
                    
                }
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted {
            if !player.isDead {
                for touch in touches {
                    let location = touch.location(in: self)
                    player.applyTorqueRight = false
                    player.applyTorqueLeft = false
                    player.isIdle = true
                    //                    rock.playerPosX = location.x
                }
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted {
            if !player.isDead {
                
                for touch in touches {
                    let location = touch.location(in: self)
                    player.refPosX = location.x
                    
                }
            }
        }
    }
    
    func startRun(totalStars: Int) {
        if !gameStarted {
            gameStarted = true
            player.isDead = false
            player.node.physicsBody?.isDynamic = true
            self.totalStars = totalStars
            flightSpeed = 1000
            player.node.position = CGPoint(x: 0, y: -640)
            player.node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            firstContactFlagPlayerRock = false
            star.isSpawnActive = false
            orange.isSpawnActive = true
            rock.isSpawnActive = true
            powerup.isSpawnActive = true
            meteor.isSpawnActive = true
            rock.resetAllPos()
            meteor.resetAllPos()
            setSpeeds(flightSpeed)
            flightDistance = 0
            flightIncrement = 0
            currentScore = 0
            playPads()
        }
    }
    
    func endRun() {
        gameStarted = false
        player.isIdle = true
        player.node.physicsBody?.isDynamic = false
        gameDelegate?.endRun(lastDistance: self.flightDistance/20000, starsCollected: self.currentScore, totalStars: totalStars)
        player.node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        player.node.position = CGPoint(x: 0, y: 0)
        player.node.zRotation = 0
        player.node.physicsBody?.angularVelocity = 0
        stopPads()
        
    }
    
    func setSpeeds(_ speed: CGFloat) {
        particles.particleSpeed = speed
        rock.speed = speed
        star.speed = speed
        player.xSpeed = speed
        //        player.torque = speed/16
        orange.speed = speed
        powerup.speed = speed
        meteor.speed = speed
    }
    
    
    
    func setAudioPlayers() {
        let sound = Bundle.main.path(forResource: "ambience", ofType: "wav")
        do {
            audioPlayerAmbience = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print("error")
        }
        audioPlayerAmbience.numberOfLoops = -1
        
        
        let sound2 = Bundle.main.path(forResource: "pads", ofType: "wav")
        do {
            audioPlayerPads = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound2!))
        } catch {
            print("error")
        }
        audioPlayerPads.volume = 0.0
        audioPlayerPads.numberOfLoops = -1
    }
        
    func mute() {
        audioPlayerAmbience.setVolume(0.0, fadeDuration: 0.1)
    }
    
    func unmute() {
        audioPlayerAmbience.setVolume(1.0, fadeDuration: 0.1)
    }
    
    
    func playAmbience() {
        audioPlayerAmbience.setVolume(1.0, fadeDuration: 1)
    }
    
    func stopAmbience() {
        audioPlayerAmbience.setVolume(0.0, fadeDuration: 1)
    }
    
    func playPads() {
        if !isSoundMuted {
            audioPlayerPads.setVolume(0.1, fadeDuration: 1)
        }
    }
    
    func stopPads() {
        audioPlayerPads.setVolume(0.0, fadeDuration: 1)
    }
    
    
    
}

