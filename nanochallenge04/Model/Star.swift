//
//  Star.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 12/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class Star: Spawnable {
    var lastTime: TimeInterval = TimeInterval(0)
    var scene: SKScene?
    let starTexture = SKTexture(imageNamed: "Star")
    var isSpawnActive = false
    var speed: CGFloat = 1000
    var starArray: [SKSpriteNode] = []
    var starCount = 1
    var timeInterval: Double = Double.random(in: Double(1)...Double(3))
    var resetPos = false
    var normalChance = 90
    var spawnChance = 100
    

    
    internal init(scene: SKScene?) {
        self.scene = scene

        for _ in 1...1 {
            let starNormalNode = SKSpriteNode(imageNamed: "Star")
            setupStar(starNormalNode, x: -1000, y: 0, speed: speed, name: "starNormalFalse", contactMask: ContactMask.starNormal.rawValue)
            starArray.append(starNormalNode)
            scene?.addChild(starNormalNode)
            
            let starDoubleNode = SKSpriteNode(imageNamed: "StarDouble")
            setupStar(starDoubleNode, x: -1000, y: 0, speed: speed, name: "starDoubleFalse", contactMask: ContactMask.starDouble.rawValue)
            starArray.append(starDoubleNode)
            scene?.addChild(starDoubleNode)
        }
        
    
        
        
        
        
        
        
        // adiciona 3 estrelas e deixa elas guardadas para serem posicionadas
//        for _ in 1...3 {
//            let starNode = SKSpriteNode(texture: texture)
//            setupStar(starNode, x: 1001, y: 0, speed: 1500)
//            starArray.append(starNode)
//            scene?.addChild(starNode)
//        }
    }
    
    func setupStar(_ starNode: SKSpriteNode, x: CGFloat, y: CGFloat, speed: CGFloat, name: String, contactMask: UInt32) {

        let collisionMask = SKTexture(imageNamed: "starCollisionMask")
        starNode.physicsBody = SKPhysicsBody(texture: collisionMask, size: collisionMask.size())
        
        
        starNode.physicsBody?.categoryBitMask = contactMask
        starNode.physicsBody?.contactTestBitMask = ContactMask.player.rawValue | ContactMask.collisionNode.rawValue
        starNode.physicsBody?.collisionBitMask = 0
        starNode.scale(to: CGSize(width: 260, height: 260))
        starNode.physicsBody?.affectedByGravity = false
        starNode.position.y = y
        starNode.position.x = x
        starNode.zPosition = 2
        starNode.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
        starNode.physicsBody?.linearDamping = 0
        starNode.physicsBody?.friction = 0
        starNode.physicsBody?.restitution = 0
        starNode.physicsBody?.mass = 0
        starNode.name = name
    }
    
    func update(_  currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        
        // dado um intervalo de tempo, spawna uma estrela
        if deltaTime > timeInterval {
            lastTime = currentTime
            if isSpawnActive {
                // rola a chance de spawnar
                let dice = Int.random(in: 1...100)
                if dice <= spawnChance {
                    // rola a chance de qual vai ser spawnada
                    let dice = Int.random(in: 1...100)
                    if dice <= normalChance {
                        
                        // spawn normal
                        for star in starArray {
                            if star.name == "starNormalFalse" {
                                let spawnPadding: CGFloat = 300
                                star.position = CGPoint(x: CGFloat.random(in: -400...400), y: 1200)
                                star.zRotation = CGFloat.random(in: 0...2*CGFloat.pi)
                                for node in scene!.children {
                                    if node.name == "rockTrue" {
                                        if abs(node.position.y - star.position.y) < spawnPadding {
                                            while abs(node.position.x - star.position.x) < spawnPadding {
                                                star.position.x = CGFloat.random(in: -400...400)
                                            }
                                        }
                                    }
                                }
                                star.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                                star.name = "starNormalTrue"
                            }
                        }
                        
                    } else {
                        // spawn doble
                        for star in starArray {
                            if star.name == "starDoubleFalse" {
                                let spawnPadding: CGFloat = 300
                                star.position = CGPoint(x: CGFloat.random(in: -400...400), y: 1200)
                                star.zRotation = CGFloat.random(in: 0...2*CGFloat.pi)

                                for node in scene!.children {
                                    if node.name == "rockTrue" {
                                        if abs(node.position.y - star.position.y) < spawnPadding {
                                            while abs(node.position.x - star.position.x) < spawnPadding {
                                                star.position.x = CGFloat.random(in: -400...400)
                                            }
                                        }
                                    }
                                }
                                star.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                                star.name = "starDoubleTrue"
                            }
                        }
                    }
                    
                    timeInterval = Double.random(in: 2...2)
                    return
                }
            }
        }
        
        // se a estrela já saiu da tela, coloca ela na posição de espera
        for star in starArray {
            if star.position.y < -1500 {
                if star.name == "starNormalTrue" {
                    star.position.x = 1001
                    star.position.y = 0
                    star.name = "starNormalFalse"
                } else if star.name == "starDoubleTrue" {
                    star.position.x = 1001
                    star.position.y = 0
                    star.name = "starDoubleFalse"
                }
            }
            if star.name == "starNormalResetPos" {
                star.position.x = 1001
                star.position.y = 0
                star.name = "starNormalFalse"
            } else if star.name == "starDoubleResetPos" {
                star.position.x = 1001
                star.position.y = 0
                star.name = "starDoubleFalse"
            }
            if star.name == "starNormalTrue" || star.name == "starDoubleTrue" {
                star.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
            }
        }
    }
    
    
    
    func spawnGroup(_ id: Int) {
        // fileira de estrelas
        if id == 1 {
            let distance = 200
            let xPos = CGFloat.random(in: CGFloat(-400)...CGFloat(400))
            for star in starArray {
                if star.name == "starFalse" {
                    if starCount == 1 {
                        star.position.y = 1200 + CGFloat(starCount * distance)
                        star.position.x = xPos
                        star.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                        star.name = "starTrue"
                        starCount += 1
                    }
                    else if starCount == 2 {
                        star.position.y = 1200 + CGFloat(starCount * distance)
                        star.position.x = xPos
                        star.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                        star.name = "starTrue"
                        starCount += 1
                    }
                    else if starCount == 3 {
                        star.position.y = 1200 + CGFloat(starCount * distance)
                        star.position.x = xPos
                        star.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                        star.name = "starTrue"
                        starCount += 1
                    }
                    else if starCount == 4 {
                        star.position.y = 1200 + CGFloat(starCount * distance)
                        star.position.x = xPos
                        star.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                        star.name = "starTrue"
                        starCount += 1
                    }
                    else if starCount == 5 {
                        star.position.y = 1200 + CGFloat(starCount * distance)
                        star.position.x = xPos
                        star.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                        star.name = "starTrue"
                        starCount = 1
                        return
                    }
                }
            }
        }
        // estrela unica
        if id == 2 {
            for star in starArray {
                if star.name == "starFalse" {
                    let spawnPadding: CGFloat = 300
                    star.position.y = 1200
                    star.position.x = CGFloat.random(in: -400...400)

                    
                    for node in scene!.children {
                        if node.name == "rockTrue" {
                            if abs(node.position.y - star.position.y) < spawnPadding {
                                while abs(node.position.x - star.position.x) < spawnPadding {
                                    star.position.x = CGFloat.random(in: -400...400)
                                }
                            }
                        }
                    }
                    
                    
                    star.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                    star.name = "starTrue"
                    return
                }
            }
        }
    }
}

