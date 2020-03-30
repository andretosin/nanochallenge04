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
    
    internal init(scene: SKScene?) {
        self.scene = scene
        let texture = SKTexture(imageNamed: "Rock")
        
        // adiciona 3 pedras e deixa elas guardadas para serem posicionadas
        for _ in 1...5 {
            let rockNode = SKSpriteNode(texture: texture)
            setupRock(rockNode, x: 1000, y: 0, speed: speed)
            rockArray.append(rockNode)
            scene?.addChild(rockNode)
        }  
    }
    
    var lastTime: TimeInterval = TimeInterval(0)
    
    
    func setupRock(_ rockNode: SKSpriteNode, x: CGFloat, y: CGFloat, speed: CGFloat) {
        
        let collisionMask = SKTexture(imageNamed: "RockMask")
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
                        let dice = Int.random(in: 1...1)
                        if dice == 1 {
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
                resetPos(rock: rock)
                return
            }
        }
        
        for rock in rockArray {
            if rock.name == "rockTrue" {
                rock.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
            }
        }
    }
    
    func resetPos(rock: SKSpriteNode) {
        rock.physicsBody?.isDynamic = false
        rock.position.x = 1000
        rock.position.y = 0
        rock.physicsBody?.angularVelocity = 0
        rock.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        rock.name = "rockFalse"
    }
    
    func resetAllPos() {
        for rock in rockArray {
            resetPos(rock: rock)
        }
    }
}





