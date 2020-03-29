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
    let fullTexture = SKTexture(imageNamed: "OneRing")
    var isSpawnActive = false
    var orangeArray: [SKSpriteNode] = []
    var speed = CGFloat(1000)
    var resetFlagFunc: (() -> Void)!
    
    let fullNode: SKSpriteNode = SKSpriteNode(imageNamed: "OneRing")
    
    internal init(scene: SKScene?, resetFlag: @escaping () -> Void) {
        self.scene = scene
        self.resetFlagFunc = resetFlag
        
        setupOrange(fullNode: fullNode, x: -1000, y: 0, speed: speed)
        
//        self.fullNode.scale(to: CGSize(width: 420*0.7, height: 424*0.7))

        
        
        
        orangeArray.append(fullNode)
        
        scene?.addChild(fullNode)
        
        
        
    }
    
    func setupOrange(fullNode: SKSpriteNode, x: CGFloat, y: CGFloat, speed: CGFloat) {
        
        let collisionMask = SKTexture(imageNamed: "starCollisionMask")
        fullNode.position = CGPoint(x: x, y: y)
        fullNode.zPosition = 4
//        fullNode.scale(to: CGSize(width: 200, height: 200))


        
        fullNode.physicsBody = SKPhysicsBody(texture: collisionMask, size: collisionMask.size())
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
                        
                        let spawnPadding: CGFloat = 400
                        for node in scene!.children {
                            if node.name == "rockTrue" {
                                if abs(node.position.y - orange.position.y) < spawnPadding {
                                    print("spawnou laranja perto de pedra")
                                    while abs(node.position.x - orange.position.x) < spawnPadding {
                                        orange.position.x = CGFloat.random(in: -400...400)
                                    }
                                }
                            }
                        }
                        
                        
                        
                        orange.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                        orange.name = "orangeTrue"
                    }
                }
                timeInterval = Double.random(in: 2...2)
            }
        }
        
        for orange in orangeArray {
            if orange.position.y < -1200 {
                orange.position.x = -1200
                orange.position.y = 0
                orange.name = "orangeFalse"
            }
        }
        
        for orange in orangeArray {
            if orange.name == "orangeTrue" {
                orange.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
            }
        }
        
        
        
        
        
        
        
        
        
    }
    
}
