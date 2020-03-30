//
//  Rock.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 12/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit


class Rock: Spawnable {
    var scene: SKScene?
    var isSpawnActive = false
    var rockArray: [SKSpriteNode] = []
    var speed: CGFloat = 1000
    var playerPosX: CGFloat = 0
    var timeInterval: Double = 1.5
    var lastTime: TimeInterval = TimeInterval(0)
    var spawnChance = 100
    
    internal init(scene: SKScene?) {
        self.scene = scene
        
        
        
        // adiciona 3 pedras e deixa elas guardadas para serem posicionadas
        for _ in 1...5 {
            let texture = Int.random(in: 1...10)
            let rockNode = SKSpriteNode(texture: SKTexture(imageNamed: "MiniRock" + String(texture)))
            setupRock(rockNode, x: 1000, y: 0, speed: speed, texture: texture)
            rockArray.append(rockNode)
            scene?.addChild(rockNode)
        }  
    }
    
    
    
    func setupRock(_ rockNode: SKSpriteNode, x: CGFloat, y: CGFloat, speed: CGFloat, texture: Int) {
        
        let collisionMask = SKTexture(imageNamed: "MiniRock" + String(texture) + "Mask")
        rockNode.physicsBody = SKPhysicsBody(texture: collisionMask, size: collisionMask.size())
        rockNode.physicsBody?.categoryBitMask = ContactMask.rock.rawValue
        rockNode.physicsBody?.contactTestBitMask = ContactMask.player.rawValue
        rockNode.physicsBody?.collisionBitMask = 0
        rockNode.scale(to: CGSize(width: 300, height: 300))
        rockNode.physicsBody?.affectedByGravity = false
        rockNode.position.y = y
        rockNode.position.x = x
        rockNode.zPosition = 1
        rockNode.physicsBody?.mass = 1000
        rockNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        rockNode.physicsBody?.linearDamping = 0
        rockNode.physicsBody?.friction = 0
        rockNode.physicsBody?.restitution = 0
        rockNode.name = "rockFalse"
        
        
    }
    
    
    func rollChance(spawnChance: Int) -> Bool {
        if spawnChance == 100 { return true }
        else if spawnChance == 90 {
            let dice = Int.random(in: 1...10)
            if dice != 10 { return true } else { return false }
        } else if spawnChance == 80 {
            let dice = Int.random(in: 1...10)
            if dice <= 8 { return true } else { return false }
        }
        else if spawnChance == 70 {
            let dice = Int.random(in: 1...10)
            if dice <= 7 { return true } else { return false }
        }
        else if spawnChance == 60 {
            let dice = Int.random(in: 1...10)
            if dice <= 6 { return true } else { return false }
        }
        else if spawnChance == 50 {
            let dice = Int.random(in: 1...10)
            if dice <= 5 { return true } else { return false }
        }
        else if spawnChance == 40 {
            let dice = Int.random(in: 1...10)
            if dice <= 4 { return true } else { return false }
        }
        else if spawnChance == 30 {
            let dice = Int.random(in: 1...10)
            if dice <= 3 { return true } else { return false }
        }
        else if spawnChance == 20 {
            let dice = Int.random(in: 1...10)
            if dice <= 2 { return true } else { return false }
        }
        else if spawnChance == 10 {
            let dice = Int.random(in: 1...10)
            if dice <= 1 { return true } else { return false }
        } else { return false }
    }
    
    
    func update(_  currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        
        if deltaTime > timeInterval {
            lastTime = currentTime
            if isSpawnActive {
                for rock in rockArray {
                    if rock.name == "rockFalse" {
                        // spawnar pedra
                        
                        if rollChance(spawnChance: spawnChance) {
                            rock.name = "rockTrue"
                            rock.physicsBody?.isDynamic = true
                            rock.position.x = CGFloat.random(in: -400 ... 400)
                            //                            rock.position.x = CGFloat.random(in: playerPosX-5 ... playerPosX + 5)
                            
                            rock.position.y = 1200
                            
                            
                            // verificar se não vai spawnar em cima de uma estrela
                            for node in scene!.children {
                                if node.name == "starTrue" || node.name == "orangeTrue" || node.name == "powerupTrue" {
                                    let spawnPadding: CGFloat = 300
                                    if abs(node.position.y - rock.position.y) < spawnPadding {
                                        while abs(node.position.x - rock.position.x) < spawnPadding {
                                            rock.position.x = CGFloat.random(in: -400...400)
                                        }
                                    }
                                }
                            }
                            rock.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                        }
                        
                        // sorteia um tempo para spawnar a nova pedra
                        timeInterval = Double.random(in: (2000/4)/Double(speed)...(2000/2)/Double(speed))
                        return
                    }
                }
            }
        }
        
        // se tiver pedras fora da tela, coloca elas na posição de espera
        for rock in rockArray {
            if rock.position.y < -1500 {
                resetPos(rock)
                return
            }
        }
        
        for rock in rockArray {
            if rock.name == "rockTrue" {
                rock.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
            }
        }
    }
    
    func resetPos(_ rock: SKSpriteNode) {
        rock.physicsBody?.isDynamic = false
        rock.position.x = 1000
        rock.position.y = 0
        rock.physicsBody?.angularVelocity = 0
        rock.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        rock.name = "rockFalse"
    }
    
    func resetAllPos() {
        for rock in rockArray {
            resetPos(rock)
        }
    }
}





