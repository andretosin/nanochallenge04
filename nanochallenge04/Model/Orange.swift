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
    var timeInterval: Double = Double.random(in: Double(1)...Double(3))
    var scene: SKScene?
    let oneRingTexture = SKTexture(imageNamed: "OneRing")
    let doubleRingTexture = SKTexture(imageNamed: "DoubleRing")
    let tripleRingTexture = SKTexture(imageNamed: "TripleRing")

    var isSpawnActive = false
    var orangeArray: [SKSpriteNode] = []
    var speed = CGFloat(1000)
    var resetFlagFunc: (() -> Void)!
    
    var spawnChance = 100
    var singleChance = 34
    var doubleChance = 33
    var tripleChance = 33
    
    let oneRingNode: SKSpriteNode = SKSpriteNode(imageNamed: "OneRing")
    let doubleRingNode: SKSpriteNode = SKSpriteNode(imageNamed: "DoubleRing")
    let tripleRingNode: SKSpriteNode = SKSpriteNode(imageNamed: "TripleRing")

    
    internal init(scene: SKScene?, resetFlag: @escaping () -> Void) {
        self.scene = scene
        self.resetFlagFunc = resetFlag
        
        setupOrange(fullNode: oneRingNode, x: -1000, y: 0, speed: speed, name: "orangeSingleFalse", maskName: "starCollisionMask", contactMask: ContactMask.orangeSingle.rawValue)
        setupOrange(fullNode: doubleRingNode, x: -1000, y: 0, speed: speed, name: "orangeDoubleFalse", maskName: "DoubleRingMask", contactMask: ContactMask.orangeDouble.rawValue)
        setupOrange(fullNode: tripleRingNode, x: -1000, y: 0, speed: speed, name: "orangeTripleFalse", maskName: "TripleRingMask", contactMask: ContactMask.orangeTriple.rawValue)
        

        
        
        
        orangeArray.append(oneRingNode)
        orangeArray.append(doubleRingNode)
        orangeArray.append(tripleRingNode)
        
        scene?.addChild(oneRingNode)
        scene?.addChild(doubleRingNode)
        scene?.addChild(tripleRingNode)
        
        
        
    }
    
    
    
    func setupOrange(fullNode: SKSpriteNode, x: CGFloat, y: CGFloat, speed: CGFloat, name: String, maskName: String, contactMask: UInt32) {
        
        let collisionMask = SKTexture(imageNamed: maskName)
        fullNode.position = CGPoint(x: x, y: y)
        fullNode.zPosition = 4
//        fullNode.scale(to: CGSize(width: 200, height: 200))


        
        fullNode.physicsBody = SKPhysicsBody(texture: collisionMask, size: collisionMask.size())
        fullNode.physicsBody?.categoryBitMask = contactMask
        fullNode.physicsBody?.contactTestBitMask = ContactMask.player.rawValue
        fullNode.physicsBody?.collisionBitMask = 0
        fullNode.physicsBody?.affectedByGravity = false
        fullNode.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
        fullNode.name = name

        
    }
    
    func fadeOut() {
        for orange in orangeArray {
            if (orange.name == "orangeSingleTrue" || orange.name == "orangeDoubleTrue" || orange.name == "orangeTripleTrue") && orange.position.y < -850 && orange.alpha != 0 {
                
//                let dropOpacity = SKAction.fadeAlpha(to: 0.0, duration: 0.1)
//                orange.run(dropOpacity)
                
                
//                orange.alpha = 0.2
            }
        }
    }
    
    func animateDissapear() {
        for orange in orangeArray {
            if orange.name == "orangeSingleTrue" || orange.name == "orangeDoubleTrue" || orange.name == "orangeTripleTrue" {
                
                let sizeScale = SKAction.scale(by: 2.0, duration: 0.1)
                let alphaAnimation = SKAction.fadeOut(withDuration: 0.1)
                
                
                orange.run(SKAction.sequence([sizeScale, alphaAnimation]))
            }
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        
        
        fadeOut()
        
        if deltaTime > timeInterval {
            lastTime = currentTime
            if isSpawnActive {
                
                let dice = Int.random(in: 1...100)
                if dice <= spawnChance {
                
                    let dice = Int.random(in: 1...100)
                    if dice <= singleChance {
                        // spawne single
                        for orange in orangeArray {
                            if orange.name == "orangeSingleFalse" {
                                self.resetFlagFunc()
                                orange.position = CGPoint(x: CGFloat.random(in: CGFloat(-300)...CGFloat(300)), y: 1200)
                                
                                let spawnPadding: CGFloat = 400
                                for node in scene!.children {
                                    if node.name == "rockTrue" {
                                        if abs(node.position.y - orange.position.y) < spawnPadding {
                                            while abs(node.position.x - orange.position.x) < spawnPadding {
                                                orange.position.x = CGFloat.random(in: -400...400)
                                            }
                                        }
                                    }
                                }
                                orange.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                                orange.name = "orangeSingleTrue"
                            }
                        }
                        
                        
                        
                        
                    } else if dice <= doubleChance {
                        // spawne double
                        for orange in orangeArray {
                            if orange.name == "orangeDoubleFalse" {
                                self.resetFlagFunc()
                                orange.position = CGPoint(x: CGFloat.random(in: CGFloat(-300)...CGFloat(300)), y: 1200)
                                let spawnPadding: CGFloat = 400
                                for node in scene!.children {
                                    if node.name == "rockTrue" {
                                        if abs(node.position.y - orange.position.y) < spawnPadding {
                                            while abs(node.position.x - orange.position.x) < spawnPadding {
                                                orange.position.x = CGFloat.random(in: -400...400)
                                            }
                                        }
                                    }
                                }
                                orange.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                                orange.name = "orangeDoubleTrue"
                            }
                        }
                        
                        
                    
                        
                    } else {
                        // spawne triple
                        for orange in orangeArray {
                            if orange.name == "orangeTripleFalse" {
                                self.resetFlagFunc()
                                orange.position = CGPoint(x: CGFloat.random(in: CGFloat(-300)...CGFloat(300)), y: 1200)
                                let spawnPadding: CGFloat = 400
                                for node in scene!.children {
                                    if node.name == "rockTrue" {
                                        if abs(node.position.y - orange.position.y) < spawnPadding {
                                            while abs(node.position.x - orange.position.x) < spawnPadding {
                                                orange.position.x = CGFloat.random(in: -400...400)
                                            }
                                        }
                                    }
                                }
                                orange.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                                orange.name = "orangeTripleTrue"
                            }
                        }
                    }
                }
                timeInterval = Double.random(in: 2...5)
                
                
                
                
                 
                
                
//
//                for orange in orangeArray {
//                    if orange.name == "orangeFalse" {
//                        // spawnar orange
//
//
//
//
//                        self.resetFlagFunc()
//                        orange.position.y = 1200
//                        orange.position.x = CGFloat.random(in: CGFloat(-300)...CGFloat(300))
//
//                        let spawnPadding: CGFloat = 400
//                        for node in scene!.children {
//                            if node.name == "rockTrue" {
//                                if abs(node.position.y - orange.position.y) < spawnPadding {
//                                    while abs(node.position.x - orange.position.x) < spawnPadding {
//                                        orange.position.x = CGFloat.random(in: -400...400)
//                                    }
//                                }
//                            }
//                        }
//                        orange.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
//                        orange.name = "orangeTrue"
//                    }
//                }
//                timeInterval = Double.random(in: 2...4)
            }
        }
        
        for orange in orangeArray {
            if orange.position.y < -1200 {
                if orange.name == "orangeSingleTrue" {
                    orange.name = "orangeSingleFalse"
                    orange.position.x = -1200
                    orange.position.y = 0
                    orange.alpha = 1
                    orange.scale(to: CGSize(width: 425, height: 189))
                } else if orange.name == "orangeDoubleTrue" {
                    orange.name = "orangeDoubleFalse"
                    orange.position.x = -1200
                    orange.position.y = 0
                    orange.alpha = 1
                    orange.scale(to: CGSize(width: 426, height: 268))
                } else if orange.name == "orangeTripleTrue" {
                    orange.name = "orangeTripleFalse"
                    orange.position.x = -1200
                    orange.position.y = 0
                    orange.alpha = 1
                    orange.scale(to: CGSize(width: 430, height: 349))
                }
            }
        }
        
        for orange in orangeArray {
            if orange.name == "orangeSingleTrue" || orange.name == "orangeDoubleTrue" || orange.name == "orangeTripleTrue" {
                orange.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
            }
        }
    }
}
