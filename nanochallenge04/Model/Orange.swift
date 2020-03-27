//
//  Orange.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 26/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class Orange: Spawnable {
    
    var lastTime: TimeInterval = TimeInterval(0)
    var timeInterval: Double = Double.random(in: Double(2)...Double(10))
    var scene: SKScene?
    let fullTexture = SKTexture(imageNamed: "OrangeFull")
    let halfTexture = SKTexture(imageNamed: "OrangeHalf")
    var isSpawnActive = false
    var orangeArray: [SKSpriteNode] = []
    var speed = CGFloat(1000)
    var resetFlagFunc: (() -> Void)!
    
    let fullNode: SKSpriteNode = SKSpriteNode(imageNamed: "OrangeFull")
    let halfNode: SKSpriteNode = SKSpriteNode(imageNamed: "OrangeHalf")
    
    internal init(scene: SKScene?, resetFlag: @escaping () -> Void) {
        self.scene = scene
        self.resetFlagFunc = resetFlag
        
        setupOrange(fullNode: fullNode, halfNode: halfNode, x: -1000, y: 0, speed: speed)
        
        self.fullNode.scale(to: CGSize(width: 420*0.7, height: 424*0.7))
        self.halfNode.scale(to: CGSize(width: 420*0.7, height: 424*0.7))

        
        
        
        orangeArray.append(fullNode)
        
        scene?.addChild(fullNode)
        scene?.addChild(halfNode)
        
        
        
    }
    
    func setupOrange(fullNode: SKSpriteNode, halfNode: SKSpriteNode, x: CGFloat, y: CGFloat, speed: CGFloat) {
        
        fullNode.position = CGPoint(x: x, y: y)
        fullNode.zPosition = 4
//        fullNode.scale(to: CGSize(width: 200, height: 200))

        halfNode.position.x = fullNode.position.x
        halfNode.position.y = fullNode.position.y
        halfNode.zPosition = 6
//        halfNode.scale(to: CGSize(width: 200, height: 200))
        
        
        fullNode.physicsBody = SKPhysicsBody(texture: fullNode
            .texture!, size: fullNode.texture!.size())
        fullNode.physicsBody?.categoryBitMask = ContactMask.orange.rawValue
        fullNode.physicsBody?.contactTestBitMask = ContactMask.player.rawValue
        fullNode.physicsBody?.collisionBitMask = 0
        fullNode.physicsBody?.affectedByGravity = false
        fullNode.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
        fullNode.name = "orangeFalse"

        
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
                for orange in orangeArray {
                    if orange.name == "orangeFalse" {
                        self.resetFlagFunc()
                        orange.position.y = 1200
                        orange.position.x = CGFloat.random(in: CGFloat(-300)...CGFloat(300))
                        orange.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                        orange.name = "orangeTrue"
                    }
                }
                timeInterval = Double.random(in: 3...9)
            }
        }
        
        for orange in orangeArray {
            if orange.position.y < -1500 {
                orange.position.x = -1000
                orange.position.y = 0
                orange.name = "orangeFalse"
            }
        }
        
        for orange in orangeArray {
            if orange.name == "orangeTrue" {
                orange.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
            }
        }
        
        
        
        
        
        
        
        halfNode.position.y = fullNode.position.y - 5
        
        
    }
    
}
