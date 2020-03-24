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
    var node: SKSpriteNode = SKSpriteNode(imageNamed: "RocketOff 2")
    var leftTexture = SKTexture(imageNamed: "RocketLeft")
    var rightTexture = SKTexture(imageNamed: "RocketRight")
    var offTexture = SKTexture(imageNamed: "RocketOff 2")

    
    var applyTorqueLeft: Bool = false
    var applyTorqueRight: Bool = false
    let limitAngle = CGFloat(Double.pi/5)
    var lastTorque: String = ""
    
    internal init(scene: GameScene?) {
        self.configurePhysics()
        self.node.scale(to: CGSize(width: 150, height: 150))
        self.node.position = CGPoint(x: 0, y: -50)
        self.node.zPosition = 5
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
    
    func update(_ deltaTime: CGFloat) {
        
        
//        self.node.physicsBody?.velocity = CGVector(dx: -1000 * self.node.zRotation, dy: 0)
        
        
        
        
        
        
        
        
//        aqui tava ok
        
//        if applyTorqueLeft {
//            if self.node.zRotation < limitAngle {
//                if self.node.physicsBody!.angularVelocity < CGFloat(3.5) {
//                    self.node.texture = rightTexture
//                    self.node.physicsBody?.applyTorque(20)
//                    self.node.physicsBody?.angularDamping = 0
//                }
//            } else {
//                self.node.physicsBody?.angularDamping = 40
//            }
//        } else {
//            if self.node.zRotation > 0 {
//                self.node.physicsBody?.angularDamping = 0
//                self.node.physicsBody?.applyTorque(-20)
//                self.node.texture = leftTexture
//            }
//        }
        
        
        
        
//
//        else {
//            if self.lastTorque == "left" {
//                if self.node.zRotation > 0 {
//                    self.node.physicsBody?.angularDamping = 0
//                    self.node.physicsBody?.applyTorque(-20)
//                    self.node.texture = leftTexture
//                } else {
//                    self.node.physicsBody?.angularDamping = 20
//                    self.node.texture = offTexture
//                    self.node.zRotation = 0
//                }
//            } else if self.lastTorque == "right" {
//                if self.node.zRotation < 0 {
//                    self.node.physicsBody?.angularDamping = 0
//                    self.node.physicsBody?.applyTorque(20)
//                    self.node.texture = leftTexture
//                } else {
//                    self.node.physicsBody?.angularDamping = 20
//                    self.node.texture = offTexture
//                    self.node.zRotation = 0
//                }
//            }
//        }
        
    }
}
