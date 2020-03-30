//
//  Meteor.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 30/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class Meteor: Spawnable {
    var scene: SKScene?
    var isSpawnActive = false
    var meteorArray: [SKSpriteNode] = []
    var speed: CGFloat = 1000
    var playerPosX: CGFloat = 0
    var timeInterval: Double = 1.5
    var lastTime: TimeInterval = TimeInterval(0)
    var spawnChance = 100

    
    internal init(scene: SKScene?) {
        self.scene = scene
        let texture = SKTexture(imageNamed: "Rock")
        
        for _ in 1...1 {
            let meteorNode = SKSpriteNode(texture: texture)
            setupMeteor(meteorNode, x: 1000, y: 0, speed: speed)
            meteorArray.append(meteorNode)
            scene?.addChild(meteorNode)
        }
    }
    
    func setupMeteor(_ meteorNode: SKSpriteNode, x: CGFloat, y: CGFloat, speed: CGFloat) {
        let collisionMask = SKTexture(imageNamed: "RockMask")
        meteorNode.physicsBody = SKPhysicsBody(texture: collisionMask, size: collisionMask.size())
        meteorNode.physicsBody?.categoryBitMask = ContactMask.rock.rawValue
        meteorNode.physicsBody?.contactTestBitMask = ContactMask.player.rawValue
        meteorNode.physicsBody?.collisionBitMask = 0
        meteorNode.scale(to: CGSize(width: 300, height: 300))
        meteorNode.physicsBody?.affectedByGravity = false
        meteorNode.position.y = y
        meteorNode.position.x = x
        meteorNode.zPosition = 1
        meteorNode.physicsBody?.mass = 1000
        meteorNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        meteorNode.physicsBody?.linearDamping = 0
        meteorNode.physicsBody?.friction = 0
        meteorNode.physicsBody?.restitution = 0
        meteorNode.name = "meteorFalse"
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
    
    func update(_ currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        
        if deltaTime > timeInterval {
            lastTime = currentTime
            if isSpawnActive {
                for meteor in meteorArray {
                    if meteor.name == "meteorFalse" {
                        // spawnar meteoro
                        if rollChance(spawnChance: spawnChance) {
                            meteor.name = "meteorTrue"
                            meteor.physicsBody?.isDynamic = true
                            meteor.position = CGPoint(x: playerPosX, y: 1200)
                            meteor.physicsBody?.velocity = CGVector(dx: 0, dy: -speed * 1.5)
                        }
                        timeInterval = Double(2)
                    }
                }
            }
        }
        
        // quando sair da tela, coloca na espera
        for meteor in meteorArray {
            if meteor.position.y < -1500 {
                resetPos(meteor)
            }
        }
        
        // atualiza a velocidade caso ela aumente durante a vida dele
        for meteor in meteorArray {
            if meteor.name == "meteorTrue" {
                meteor.physicsBody?.velocity = CGVector(dx: 0, dy: -speed * 1.5)
            }
        }
    }
    
    func resetPos(_ meteor: SKSpriteNode) {
        meteor.position = CGPoint(x: 1001, y: 0)
        meteor.name = "meteorFalse"
    }
    
    func resetAllPos() {
        for meteor in meteorArray {
            resetPos(meteor)
        }
    }
    
    
    
}
