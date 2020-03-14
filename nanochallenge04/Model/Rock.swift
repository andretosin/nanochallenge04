//
//  Rock.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 12/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit


class Rock: Spawnable {
    var node = SKSpriteNode(imageNamed: "Rock")
    var scene: SKScene?
    var isSpawnActive = true
    var rockArray: [SKSpriteNode] = []
    var speed: CGFloat = 1000
    var playerPosX: CGFloat = 0
    
    internal init(scene: SKScene?) {
        self.scene = scene
        
        for _ in 1...10 {
            let rockNode = SKSpriteNode(imageNamed: "Rock")
            setupRock(rockNode, x: 1000, y: 0, speed: speed)
            rockArray.append(rockNode)
            scene?.addChild(rockNode)
        }
        
        
    }
    
    var lastTime: TimeInterval = TimeInterval(0)
    
    
    func setupRock(_ rockNode: SKSpriteNode, x: CGFloat, y: CGFloat, speed: CGFloat) {
        rockNode.physicsBody = SKPhysicsBody(texture: rockNode.texture!, size: rockNode.texture!.size())
        rockNode.physicsBody?.categoryBitMask = ContactMask.rock.rawValue
        rockNode.physicsBody?.contactTestBitMask = ContactMask.player.rawValue
        rockNode.physicsBody?.collisionBitMask = 0
        rockNode.scale(to: CGSize(width: 300, height: 300))
        rockNode.physicsBody?.affectedByGravity = false
        rockNode.position.y = y
        rockNode.position.x = x
        rockNode.zPosition = 1
        rockNode.physicsBody?.mass = 10
        rockNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        rockNode.physicsBody?.linearDamping = 0
        rockNode.name = "rockFalse"
    }
    
    
    
    
    func update(_  currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        
        if deltaTime > Double.random(in: (2000/3)/Double(speed)...5*2000/Double(speed))    {
            lastTime = currentTime
            if isSpawnActive {
                for rock in rockArray {
                    if rock.name == "rockFalse" {
                        // spawn
                        rock.name = "rockTrue"
                        rock.physicsBody?.collisionBitMask = ContactMask.rock.rawValue | ContactMask.player.rawValue
                        rock.position.x = playerPosX
//                        rock.position.x = CGFloat(Int.random(in: -450...450))
                        rock.position.y = 1200
                        rock.physicsBody?.velocity = CGVector(dx: 0, dy: -speed)
                        return
                    }
                }
            }
        }
        
        for rock in rockArray {
            if rock.position.y < -1500 {
                rock.position.x = 1000
                rock.position.y = 0
                rock.physicsBody?.angularVelocity = 0
                rock.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                rock.name = "rockFalse"
                rock.physicsBody?.collisionBitMask = 0
                speed += 100
                print(speed)
                return
            }
        }
    }
}



/*
 
 
 let randomPos = CGFloat(Int.random(in: -450...450))
 let node = SKSpriteNode(imageNamed: "Rock")
 node.physicsBody = SKPhysicsBody(texture: node.texture!, size: node.texture!.size())
 node.physicsBody?.categoryBitMask = ContactMask.rock.rawValue
 node.physicsBody?.contactTestBitMask = ContactMask.player.rawValue
 node.physicsBody?.collisionBitMask = ContactMask.player.rawValue
 node.scale(to: CGSize(width: 300, height: 300))
 node.physicsBody?.affectedByGravity = false
 node.position.y = 1200
 
 node.position.x = randomPos
 node.physicsBody?.velocity = CGVector(dx: 0, dy: -1500)
 node.physicsBody?.mass = 2
 node.zPosition = 2
 node.zRotation = CGFloat.random(in: 0...CGFloat(Double.pi))
 scene?.addChild(node)
 
 
 
 */




