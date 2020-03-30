//
//  Powerup.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 29/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class PowerUp: Spawnable {
    var lastTime: TimeInterval = TimeInterval(0)
    var scene: SKScene?
    let watermelonTexture = SKTexture(imageNamed: "PowerUpWatermelon")
    let watermelonMask = SKTexture(imageNamed: "PowerUpWatermelonMask")
    var isSpawnActive = false
    var speed: CGFloat = 1000
    var powerUpArray: [SKSpriteNode] = []
    var timeInterval: Double = Double.random(in: Double(5)...Double(10))
    
    internal init(scene: SKScene?) {
        self.scene = scene
        
        let watermelonNode = SKSpriteNode(texture: watermelonTexture)
        setupWatermelon(node: watermelonNode, x: 1001, y: 0, speed: 0)
        powerUpArray.append(watermelonNode)
        scene?.addChild(watermelonNode)
        
        
    }
    
    func setupWatermelon(node: SKSpriteNode, x: CGFloat, y: CGFloat, speed: CGFloat) {
        node.physicsBody = SKPhysicsBody(texture: watermelonTexture, size: watermelonTexture.size())
        node.physicsBody?.categoryBitMask = ContactMask.watermelon.rawValue
        node.physicsBody?.contactTestBitMask = ContactMask.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.physicsBody?.affectedByGravity = false
        node.position = CGPoint(x: x, y: y)
        node.zPosition = 2
        node.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
        node.physicsBody?.linearDamping = 0
        node.physicsBody?.friction = 0
        node.physicsBody?.restitution = 0
        node.physicsBody?.mass = 0
        node.name = "powerupFalse"
    }
    
    func spawnWatermelon() {
        for powerup in powerUpArray {
            if powerup.name == "powerupFalse" {
                powerup.position.y = 1200
                powerup.position.x = CGFloat.random(in: CGFloat(-400)...CGFloat(400))
                
                // verificar se nao vai spawnar em cima de uma pedra
                for node in scene!.children {
                    if node.name == "rockTrue" {
                        let spawnPadding: CGFloat = 300
                        if abs(node.position.x - powerup.position.x) < spawnPadding {
                            while abs(node.position.x - powerup.position.x) < spawnPadding {
                                powerup.position.x = CGFloat.random(in: -400...400)
                            }
                        }
                    }
                }
                
                
                
                powerup.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                powerup.name = "powerupTrue"
            }
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        
        // dado um intervalo de tempo, spawna um powerup
        if deltaTime > timeInterval {
            lastTime = currentTime
            if isSpawnActive {
                let dice = Int.random(in: 1...1)
                // 100% de chance de spawnar um watermelon
                if dice == 1 {
                    spawnWatermelon()
                }
                timeInterval = Double.random(in: 5...10)
            }
        }
        
        // se algum powerup sair da tela, coloca na posicao de espera
        
        for powerup in powerUpArray {
            if powerup.position.y < -1500 && powerup.name == "powerupTrue" {
                powerup.position = CGPoint(x: 1001, y: 0)
                powerup.name = "powerupFalse"
            }
        }
        
        for powerup in powerUpArray {
            if powerup.name == "powerupTrue" {
                powerup.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
            }
        }
        
    }
}
