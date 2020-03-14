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
    var isSpawnActive = true
    var speed: CGFloat = 1000
    var starArray: [SKSpriteNode] = []
    
    internal init(scene: SKScene?) {
        self.scene = scene
        
        for _ in 1...10 {
            let starNode = SKSpriteNode(imageNamed: "Star")
            setupStar(starNode, x: 1001, y: 0, speed: 1500)
            starArray.append(starNode)
            scene?.addChild(starNode)
        }
    }
    
    func update(_  currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        
        if deltaTime > 1 {
            lastTime = currentTime
            if isSpawnActive {
                spawnGroup(1)
            }
        }
        for star in starArray {
            if star.position.y < -1500 {
                star.position.x = 1001
                star.position.y = 0
                star.name = "starFalse"
            }
        }
    }
    
    
    func spawnGroup(_ id: Int) {
        if id == 1 {
            for star in starArray {
                if star.position.x > 1000 && star.name == "starFalse" {
                    star.position.y = 1200
                    star.position.x = 0
                    star.name = "starTrue"
                    return
                }
            }
        }
    }
    
    
    func setupStar(_ starNode: SKSpriteNode, x: CGFloat, y: CGFloat, speed: CGFloat) {
        starNode.physicsBody = SKPhysicsBody(texture: starNode.texture!, size: starNode.texture!.size())
        starNode.physicsBody?.categoryBitMask = ContactMask.star.rawValue
        starNode.physicsBody?.contactTestBitMask = ContactMask.player.rawValue
        starNode.physicsBody?.collisionBitMask = 0
        starNode.scale(to: CGSize(width: 300, height: 300))
        starNode.physicsBody?.affectedByGravity = false
        starNode.position.y = y
        starNode.position.x = x
        starNode.zPosition = 2
        starNode.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
        starNode.name = "starFalse"
        starNode.physicsBody?.linearDamping = 0
    
    }
    
    
    
    
    
}




/*
 let randomPos = Int.random(in: -400...400)
      let star1 = SKSpriteNode(texture: starTexture)
      let star2 = SKSpriteNode(texture: starTexture)
      let star3 = SKSpriteNode(texture: starTexture)
      let star4 = SKSpriteNode(texture: starTexture)
      let star5 = SKSpriteNode(texture: starTexture)
      setupStar(star1, x: CGFloat(randomPos), y: 1200, speed: speed)
      setupStar(star2, x: CGFloat(randomPos), y: 1400, speed: speed)
      setupStar(star3, x: CGFloat(randomPos), y: 1600, speed: speed)
      setupStar(star4, x: CGFloat(randomPos), y: 1800, speed: speed)
      setupStar(star5, x: CGFloat(randomPos), y: 2000, speed: speed)
      scene?.addChild(star1)
      scene?.addChild(star2)
      scene?.addChild(star3)
      scene?.addChild(star4)
      scene?.addChild(star5)*/
