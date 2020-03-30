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
                        let dice = Int.random(in: 1...1)
                        if dice == 1 {
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
                meteor.position = CGPoint(x: 1001, y: 0)
                meteor.name = "meteorFalse"
            }
        }
        
        // atualiza a velocidade caso ela aumente durante a vida dele
        for meteor in meteorArray {
            if meteor.name == "meteorTrue" {
                meteor.physicsBody?.velocity = CGVector(dx: 0, dy: -speed * 1.5)
            }
        }
    }
}
