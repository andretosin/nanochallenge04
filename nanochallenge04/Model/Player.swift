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
    var resetPos: Bool = false {
        didSet {
            torqueApplied = false
        }
    }
    var lastTime = TimeInterval(0)
    var torqueApplied: Bool = false
    let zRotationAngle = CGFloat(Double.pi/4)
    let notification = UIImpactFeedbackGenerator(style: .heavy)
    let rollRate: CGFloat = 50
    var accelerateRight: Bool = false
    var accelerateLeft: Bool = false
    
    internal init(scene: GameScene?, node: SKSpriteNode?) {
        self.scene = scene
        self.node = node
        self.configurePhysics()
    }
    
    
    var scene: GameScene!
    var node: SKSpriteNode!
    
    func update(_ deltaTime: CGFloat) {
        
        
        
        if accelerateLeft {
            if self.node.physicsBody!.velocity.dx > CGFloat(-1000) {
                self.node.physicsBody?.applyForce(CGVector(dx: -5000, dy: 0))
            }
        } else if accelerateRight {
            if self.node.physicsBody!.velocity.dx < CGFloat(1000) {
                self.node.physicsBody?.applyForce(CGVector(dx: 5000, dy: 0))
            }
        }
    }
    
    func configurePhysics() {
        if let body = self.node.physicsBody {
            body.categoryBitMask = ContactMask.player.rawValue
            body.contactTestBitMask = ContactMask.star.rawValue
            body.collisionBitMask = ContactMask.rock.rawValue
            body.isDynamic = true
            body.affectedByGravity = false
        }
    }
    
    func rollLeft(_ rollRate: CGFloat) {
        if rollingRight {
            self.node.physicsBody?.angularVelocity = 0
            rollingRight = false
        }
        notification.impactOccurred()
        self.node.physicsBody?.applyTorque(CGFloat(rollRate))
        rollingLeft = true
    }
    
    func rollRight(_ rollRate: CGFloat) {
        if rollingLeft {
            self.node.physicsBody?.angularVelocity = 0
            rollingLeft = false
        }
        
        notification.impactOccurred()
        
        self.node.physicsBody?.applyTorque(CGFloat(-rollRate))
        rollingRight = true
    }
    
    func checkRotationLimits() {
        if self.node.zRotation > zRotationAngle {
            self.node.physicsBody?.angularVelocity = 0
            self.node.zRotation -= 0.01
        } else if self.node.zRotation < -zRotationAngle {
            self.node.physicsBody?.angularVelocity = 0
            self.node.zRotation += 0.01
        }
    }
    
    
    
}
