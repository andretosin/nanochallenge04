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
    
    internal init(scene: SKScene?) {
        self.scene = scene
        let texture = SKTexture(imageNamed: "Star")
        
        // adiciona 3 estrelas e deixa elas guardadas para serem posicionadas
        for _ in 1...3 {
            let starNode = SKSpriteNode(texture: texture)
            setupStar(starNode, x: 1001, y: 0, speed: 1500)
            starArray.append(starNode)
            scene?.addChild(starNode)
        }
    }
    
    func setupStar(_ starNode: SKSpriteNode, x: CGFloat, y: CGFloat, speed: CGFloat) {
        starNode.physicsBody = SKPhysicsBody(texture: starNode.texture!, size: starNode.texture!.size())
        starNode.physicsBody?.categoryBitMask = ContactMask.star.rawValue
        starNode.physicsBody?.contactTestBitMask = ContactMask.player.rawValue
        starNode.physicsBody?.collisionBitMask = 0
        starNode.scale(to: CGSize(width: 150, height: 150))
        starNode.physicsBody?.affectedByGravity = false
        starNode.position.y = y
        starNode.position.x = x
        starNode.zPosition = 2
        starNode.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
        starNode.name = "starFalse"
        starNode.physicsBody?.linearDamping = 0
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
                let dice = Int.random(in: 1...20)
                // 5% de chance de spawnar uma fileira de estrelas
                if dice == 20 {
                    spawnGroup(1)
                } else {
                    spawnGroup(2)
                }
                timeInterval = Double.random(in: 1.5...2.5)
            }
        }
        
        // se a estrela já saiu da tela, coloca ela na posição de espera
        for star in starArray {
            if star.position.y < -1500 || star.name == "starResetPos" {
                star.position.x = 1001
                star.position.y = 0
                star.name = "starFalse"
            }
        }
        
        for star in starArray {
            if star.name == "starTrue" {
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

