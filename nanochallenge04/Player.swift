//
//  Player.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 06/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//



import SpriteKit
import UIKit

class Player: Updatable {
    
    var rollingRight: Bool = false
    var rollingLeft: Bool = false
    let zRotationAngle = CGFloat(Double.pi/4)
    let notification = UIImpactFeedbackGenerator(style: .heavy)
    
    internal init(scene: GameScene?, node: SKSpriteNode?) {
        self.scene = scene
        self.node = node
        self.configurePhysics()
    }
    
    
    var scene: GameScene!
    var node: SKSpriteNode!
    
    func update(_ deltaTime: CGFloat) {
        checkLimits()
        if self.node.zRotation > 0 {
            self.node.position.x -= abs(20 * self.node.zRotation)

        } else if self.node.zRotation < 0 {
            self.node.position.x += abs(20 * self.node.zRotation)

        }
    }
    
    func configurePhysics() {
        if let body = self.node.physicsBody {
            body.categoryBitMask = ContactMask.player.rawValue
//            body.contactTestBitMask = ContactMask.walls.rawValue
            body.collisionBitMask = ContactMask.walls.rawValue
        }
    }
    
    func rollLeft() {
        if rollingRight {
            self.node.physicsBody?.angularVelocity = 0
            rollingRight = false
        }
        notification.impactOccurred()
        self.node.physicsBody?.applyTorque(CGFloat(Int.random(in: 100...110)))
        rollingLeft = true
    }
    
    func rollRight() {
        if rollingLeft {
            self.node.physicsBody?.angularVelocity = 0
            rollingLeft = false
        }
        
        notification.impactOccurred()

        self.node.physicsBody?.applyTorque(CGFloat(Int.random(in: 100...110)) * -1)
        rollingRight = true
    }
    
    func checkLimits() {
        if self.node.zRotation > zRotationAngle {
            self.node.physicsBody?.angularVelocity = 0
            self.node.zRotation -= 0.01
        } else if self.node.zRotation < -zRotationAngle {
            self.node.physicsBody?.angularVelocity = 0
            self.node.zRotation += 0.01
        }
    }
    
  

}
