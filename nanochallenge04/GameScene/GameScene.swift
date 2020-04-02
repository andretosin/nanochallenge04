//
//  GameScene.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 04/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit
import AVFoundation
import GoogleMobileAds

extension CGFloat {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

protocol GameDelegate {
    func endRun(lastDistance: CGFloat, starsCollected: Int, totalStars: Int)
    func updateLabels(flightDistance: String, currentScore: String)
    func updateSlices(slices: Int)
}

protocol GameAdDelegate {
    func showAd()
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var intersticial: GADInterstitial!
    var firstContactFlagPlayerRock: Bool = false
    var firstContactFlagPlayerOrange: Bool = false
    var gameDelegate: GameDelegate?
    var gameAdDelegate: GameAdDelegate?
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
                meteor.isSpawnActive = false
                player.b1.toggle()
                
                // desativa colisao
                for rock in rock.rockArray {
                    rock.physicsBody?.categoryBitMask = 0
                }
                for meteor in meteor.meteorArray {
                    meteor.physicsBody?.categoryBitMask = 0
                }
            } else {
                flightSlowdown = 0.2
                rock.isSpawnActive = true
                orange.isSpawnActive = true
                meteor.isSpawnActive = true
                
                // ativa colisao
                for rock in rock.rockArray {
                    rock.physicsBody?.categoryBitMask = ContactMask.rock.rawValue
                }
                for meteor in meteor.meteorArray {
                    meteor.physicsBody?.categoryBitMask = ContactMask.rock.rawValue
                }
            }
        }
    }
    
    var slices = 0
    var flightSlowdown: CGFloat = 0.2
    var deathCount = 0 {
        didSet {
            print(self.deathCount)
        }
    }
    
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
        var lightYears = flightDistance/200000
        
        let auxSlices = getSlices()
        if auxSlices != slices {
            gameDelegate?.updateSlices(slices: auxSlices)
        }
        slices = auxSlices
        
        
        
        
        
        if gameStarted {
            player.update(CGFloat(deltaTime))
            rock.update(currentTime)
            star.update(currentTime)
            meteor.update(currentTime)
            orange.update(currentTime)
            meteor.playerPosX = player.node.position.x
            
            lightYears = lightYears * 10
            if lightYears >= 10 && lightYears < 15 {
                rock.isSpawnActive = true
                rock.spawnChance = 20
            } else if lightYears >= 15 && lightYears < 25 {
                //                rock.isSpawnActive = true
                rock.spawnChance = 50
            } else if lightYears >= 25 && lightYears < 28 {
                rock.spawnChance = 25
                meteor.isSpawnActive = true
                meteor.spawnChance = 100
            } else if lightYears >= 28 && lightYears < 34 {
                rock.spawnChance = 35
                meteor.isSpawnActive = false
                orange.isSpawnActive = true
                orange.singleChance = 100
                orange.spawnChance = 100
            } else if lightYears >= 34 && lightYears < 40 {
                rock.spawnChance = 70
                orange.isSpawnActive = false
            } else if lightYears >= 40 && lightYears < 50 {
                rock.spawnChance = 45
                orange.isSpawnActive = true
                orange.singleChance = 100
                orange.spawnChance = 80
                meteor.isSpawnActive = true
                meteor.spawnChance = 40
            } else if lightYears >= 50 && lightYears < 60 {
                rock.spawnChance = 40
                orange.isSpawnActive = true
                orange.singleChance = 100
                orange.spawnChance = 70
            } else if lightYears >= 60 && lightYears < 80 {
                rock.spawnChance = 50
                orange.isSpawnActive = true
                orange.singleChance = 100
                orange.spawnChance = 90
                //                meteor.isSpawnActive = true
                meteor.spawnChance = 80
            } else if lightYears >= 80 && lightYears < 100 {
                rock.spawnChance = 65
                orange.isSpawnActive = true
                orange.singleChance = 100
                orange.spawnChance = 80
                //                meteor.isSpawnActive = true
                meteor.spawnChance = 80
            } else if lightYears >= 100 && lightYears < 150 {
                rock.spawnChance = 80
                orange.singleChance = 80
                orange.doubleChance = 100
                orange.spawnChance = 90
            } else if lightYears >= 150 && lightYears < 200 {
                rock.spawnChance = 100
                orange.singleChance = 60
                orange.spawnChance = 100
                orange.doubleChance = 100
                //                meteor.isSpawnActive = true
                meteor.spawnChance = 20
            } else if lightYears >= 200 && lightYears < 250 {
                meteor.spawnChance = 60
                orange.singleChance = 30
                orange.doubleChance = 40
//                orange.tripleChance = 30
            } else {
                meteor.spawnChance = 60
                orange.singleChance = 50
                orange.doubleChance = 90
            }
            lightYears = lightYears/10
            
            if self.flightSpeed > 1000 {
                self.flightSpeed -= flightSlowdown
            }
            
            if self.flightSpeed > 1000 && isBoostActive {
                isBoostActive = false
            }
            
            if !player.isDead {
                self.flightIncrement = rock.speed
                self.flightDistance += flightIncrement
                gameDelegate?.updateLabels(flightDistance: "\(Int((lightYears*10)))", currentScore: String(self.currentScore))
            }
        } else {
            self.player.node.position = CGPoint(x: 0, y: -50)
            self.player.fireEmitter.position = CGPoint(x: 0, y: -50)
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
                if !isBoostActive {
                    firstContactFlagPlayerRock = true
                    player.isDead = true
                    star.isSpawnActive = false
                    rock.isSpawnActive = false
                    orange.isSpawnActive = false
                    player.isDead = true
                    //                player.node.physicsBody?.allowsRotation = false
                    totalStars += self.currentScore
                    deathCount += 1
                    player.node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                    
                    // salva a quantidade de moedas
                    let defaults = UserDefaults.standard
                    defaults.set(totalStars, forKey: "starsCollected")
                    
                    // pequeno delay após morrer para voltar par ao menu
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.endRun()
                    }
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
            star.isSpawnActive = true
            orange.isSpawnActive = false
            rock.isSpawnActive = false
            meteor.isSpawnActive = false
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
        gameDelegate?.endRun(lastDistance: (flightDistance/20000), starsCollected: self.currentScore, totalStars: totalStars)
        player.node.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        player.node.position = CGPoint(x: 0, y: 0)
        player.node.zRotation = 0
        player.node.physicsBody?.angularVelocity = 0
        stopPads()
        if deathCount > 2 {
            gameAdDelegate?.showAd()
            deathCount = 0
        }
    }
    
    func setSpeeds(_ speed: CGFloat) {
        particles.particleSpeed = speed
        rock.speed = speed
        star.speed = speed
        player.xSpeed = speed
        orange.speed = speed
        meteor.speed = speed
    }
    
    func getSlices() -> Int {
        if flightSpeed > 1000 {
            // fs > 1000
            if flightSpeed > 1200 {
                // fs > 1200
                if flightSpeed > 1400 {
                    // fs > 1400
                    if flightSpeed > 1600 {
                        // fs > 1600
                        if flightSpeed > 1800 {
                            // fs > 1800
                            if flightSpeed > 2000 {
                                // fs > 2000
                                //                                gameDelegate?.updateSlices(slices: 6)
                                return 6
                            } else {
                                // fs < 2000
                                //                                gameDelegate?.updateSlices(slices: 5)
                                return 5
                            }
                        } else {
                            // fs < 1800
                            //                            gameDelegate?.updateSlices(slices: 4)
                            return 4
                        }
                    } else {
                        // fs < 1600
                        //                        gameDelegate?.updateSlices(slices: 3)
                        return 3
                    }
                } else {
                    // fs < 14000
                    //                    gameDelegate?.updateSlices(slices: 2)
                    return 2
                }
            } else {
                // fs < 1200
                //                gameDelegate?.updateSlices(slices: 1)
                return 1
            }
        } else {
            // fs < 1000
            //            gameDelegate?.updateSlices(slices: 0)
            return 0
        }
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

