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
    
    
    
    //    var rollingRight: Bool = false
    //    var rollingLeft: Bool = false
    //    var resetPos: Bool = false {
    //        didSet {
    //            torqueApplied = false
    //        }
    //    }
    //    var lastTime = TimeInterval(0)
    //    var torqueApplied: Bool = false
    //    let zRotationAngle = CGFloat(Double.pi/4)
    //    let notification = UIImpactFeedbackGenerator(style: .heavy)
    //    let rollRate: CGFloat = 50
    //    var accelerateRight: Bool = false
    //    var accelerateLeft: Bool = false
    
    
    
    
    
    var scene: GameScene!
    var node: SKSpriteNode = SKSpriteNode(imageNamed: "RocketOff-1")
    var leftTexture = SKTexture(imageNamed: "RocketLeft-1")
    var rightTexture = SKTexture(imageNamed: "RocketRight-1")
    var offTexture = SKTexture(imageNamed: "RocketOff-1")
    
    
    var applyTorqueLeft: Bool = false
    var applyTorqueRight: Bool = false
    var isIdle: Bool = true
    var isDead: Bool = false
    var refPosX: CGFloat = 0
    
    
    
    let limitAngle = CGFloat(Double.pi/6)
    let speedLimit = CGFloat(6)
    let positionLimit = CGFloat(350)
    let damping = CGFloat(30)
    var xSpeed = CGFloat(1000)
    var torque = CGFloat(30)

    
    
    internal init(scene: GameScene?) {
        self.configurePhysics()
        self.node.scale(to: CGSize(width: 250, height: 250))
        self.node.position = CGPoint(x: 0, y: -50)
        self.node.zPosition = 2
        scene?.addChild(self.node)
    }
    
    func configurePhysics() {
        self.node.physicsBody = SKPhysicsBody(texture: self.node.texture!, size: self.node.texture!.size())
        let body = self.node.physicsBody
        body?.categoryBitMask = ContactMask.player.rawValue
        body?.contactTestBitMask = ContactMask.star.rawValue
        body?.collisionBitMask = ContactMask.rock.rawValue
        body?.isDynamic = true
        body?.affectedByGravity = false
        body?.allowsRotation = true
    }
    
    func setSkin(index: Int) {
        self.node.texture = SKTexture(imageNamed: "RocketOff-" + String(index))
        self.leftTexture = SKTexture(imageNamed: "RocketLeft-" + String(index))
        self.rightTexture = SKTexture(imageNamed: "RocketRight-" + String(index))
        self.offTexture = SKTexture(imageNamed: "RocketOff-" + String(index))
    }
    
    func update(_ deltaTime: CGFloat) {
        
        if !isDead {
            self.node.physicsBody?.velocity = CGVector(dx: -xSpeed * self.node.zRotation, dy: 0)
        }
        
       
      
        
        if applyTorqueRight {
            if self.node.position.x < CGFloat(positionLimit) {
                if self.node.zRotation > -limitAngle {
                    self.node.physicsBody?.angularDamping = 0
                    if abs(self.node.physicsBody!.angularVelocity) < speedLimit {
                        self.node.physicsBody?.applyTorque(-torque)
                    }
                    self.node.texture = leftTexture
                    
                } else {
                    self.node.physicsBody?.angularDamping = damping
                }
            } else {
                isIdle = true
                applyTorqueRight = false
            }
        }
        
        
        
        if applyTorqueLeft {
            if self.node.position.x > CGFloat(-positionLimit) {
                if self.node.zRotation < limitAngle {
                    self.node.physicsBody?.angularDamping = 0
                    if abs(self.node.physicsBody!.angularVelocity) < speedLimit {
                        self.node.physicsBody?.applyTorque(torque)
                    }
                    self.node.texture = rightTexture
                } else {
                    self.node.physicsBody?.angularDamping = damping
                }
            } else {
                isIdle = true
                applyTorqueLeft = false
            }
        }
        
        if isIdle && self.node.zRotation != 0 {
            if self.node.zRotation > 0.2 {
                self.node.physicsBody?.angularDamping = 0
                self.node.physicsBody?.applyTorque(-torque/1.5)
                self.node.texture = leftTexture
            } else if self.node.zRotation < -0.2 {
                self.node.physicsBody?.angularDamping = 0
                self.node.physicsBody?.applyTorque(torque/1.5)
                self.node.texture = rightTexture
            } else {
                self.node.zRotation = 0
                self.node.physicsBody?.angularVelocity = 0
                self.node.texture = offTexture
            }
        }
    }
}
