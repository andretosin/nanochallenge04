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
    var torqueApplied: Bool = false
    let zRotationAngle = CGFloat(Double.pi/4)
    let notification = UIImpactFeedbackGenerator(style: .heavy)
    let rollRate: CGFloat = 50
    
    internal init(scene: GameScene?, node: SKSpriteNode?) {
        self.scene = scene
        self.node = node
        self.configurePhysics()
    }
    
    
    var scene: GameScene!
    var node: SKSpriteNode!
    
    func update(_ deltaTime: CGFloat) {
        // testa o angulo limite de rotacao
        checkRotationLimits()
        
        
        
        
//        if resetPos {
//            if self.node.position.x > 0 {
//                if !torqueApplied {
//                    rollLeft(rollRate)
//                    torqueApplied = true
//                }
//            } else {
//                if !torqueApplied {
//                    rollRight(rollRate)
//                    torqueApplied = true
//
//                }
//            }
//        }
        
        
                if resetPos {
                    if self.node.position.x > 0 {
                        if !torqueApplied {
                            rollLeft(rollRate)
                            torqueApplied = true
                        } else {
                            if self.node.zRotation > 0 {
                                self.node.physicsBody?.angularVelocity = 0
                                self.node.zRotation = 0.0
                                resetPos = false
                            }
                        }
        
        
                    } else {
                        if !torqueApplied {
                            rollRight(rollRate)
                            torqueApplied = true
                        } else {
                            if self.node.zRotation < 0 {
                                self.node.physicsBody?.angularVelocity = 0
                                self.node.zRotation = 0.0
                                resetPos = false
                            }
                        }
                    }
                }
        
        
        
        // atualiza posicao com base no agulo de rotacao
        self.node.position.x -= 20 * self.node.zRotation
        
        
    }
    
    func configurePhysics() {
        if let body = self.node.physicsBody {
            body.categoryBitMask = ContactMask.player.rawValue
            body.contactTestBitMask = ContactMask.walls.rawValue
            body.collisionBitMask = 0
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
