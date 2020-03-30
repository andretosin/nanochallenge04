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
    
    
    var scene: GameScene!
    var node: SKSpriteNode = SKSpriteNode(imageNamed: "RocketOff-2")
    var leftTexture = SKTexture(imageNamed: "RocketLeft-2")
    var rightTexture = SKTexture(imageNamed: "RocketRight-2")
    var offTexture = SKTexture(imageNamed: "RocketOff-2")
    var collisionMask = SKTexture(imageNamed: "RocketMask-2")
    
    
    var applyTorqueLeft: Bool = false
    var applyTorqueRight: Bool = false
    var isIdle: Bool = true
    var isDead: Bool = false
    var refPosX: CGFloat = 0
    
    
    var b1 = false
    var b2 = false
    
    
    let limitAngle = CGFloat(Double.pi/7)
    let speedLimit = CGFloat(6)
    let positionLimit = CGFloat(350)
    let damping = CGFloat(30)
    var xSpeed = CGFloat(1000)
    var torque = CGFloat(5)

    
    
    internal init(scene: GameScene?) {
        self.configurePhysics()
        self.node.scale(to: CGSize(width: 314/1.4, height: 428/1.4))
        self.node.position = CGPoint(x: 0, y: -50)
        self.node.zPosition = 2
        scene?.addChild(self.node)
    }
    
    func configurePhysics() {
        
        self.node.physicsBody = SKPhysicsBody(texture: self.collisionMask, size: self.collisionMask.size())
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
        self.collisionMask = SKTexture(imageNamed: "RocketMask-" + String(index))
    }
    
    func update(_ deltaTime: CGFloat) {
        
        if !isDead {
            self.node.physicsBody?.velocity.dx = -xSpeed * self.node.zRotation
            
            if isIdle {
                if abs(self.node.zRotation) > limitAngle + 0.2{
                    if self.node.zRotation > 0 {
                        self.node.zRotation = limitAngle + 0.2
                    } else {
                        self.node.zRotation = -limitAngle - 0.2
                    }
                }
            }
            
            
            if b1 != b2 {
                self.node.position.y += 6
                if self.node.position.y > -250 {
                    b2.toggle()
                }
            } else {
                if self.node.position.y > -640 {
                    self.node.position.y -= 0.8
                }
            }
        }
        
       
      
        // ir p direita
        if applyTorqueRight {
            if self.node.position.x < CGFloat(positionLimit) {
                // se ainda tem espaço para ir para a direita
                if self.node.zRotation > -limitAngle {
//                    if self.node.zRotation <= 0 {  ##############################################
                        // se o angulo de rotação for maior que o angulo limite ~(-0,52)
                        self.node.physicsBody?.angularDamping = 0 // zera o atrito
                        if abs(self.node.physicsBody!.angularVelocity) < speedLimit {
                            // se ainda nao acelerou ate o maximo, aplique o torque
                            self.node.physicsBody?.applyTorque(-torque)
                        }
                        self.node.texture = leftTexture
//                    } else {  ##############################################
//                        // se o angulo ultrapassou o meio para a esquerda  ##############################################
//                        self.node.zRotation = 0  ##############################################
//                        self.node.physicsBody?.angularVelocity = 0  ##############################################
//                    }  ##############################################
                } else {
                    // senão, aplique o atrito para parar
                    self.node.physicsBody?.angularDamping = damping
                }
            } else {
                // senão, pare
                isIdle = true
                applyTorqueRight = false
            }
        }
        
        
        
        // ir p esquerda
        if applyTorqueLeft {
            if self.node.position.x > CGFloat(-positionLimit) {
                if self.node.zRotation < limitAngle {
//                    if self.node.zRotation >= 0 {  ##############################################
                        self.node.physicsBody?.angularDamping = 0
                        if abs(self.node.physicsBody!.angularVelocity) < speedLimit {
                            self.node.physicsBody?.applyTorque(torque)
                        }
                        self.node.texture = rightTexture
//                    } else {  ##############################################
//                        self.node.zRotation = 0  ##############################################
//                        self.node.physicsBody?.angularVelocity = 0  ##############################################
//                    }  ##############################################
                } else {
                    self.node.physicsBody?.angularDamping = damping
                }
            } else {
                isIdle = true
                applyTorqueLeft = false
            }
        }
        
        if isIdle && self.node.zRotation != 0 {
            if self.node.zRotation > 0.1 {
                self.node.physicsBody?.angularDamping = 0
                self.node.physicsBody?.applyTorque(-torque/1.5)
                self.node.texture = leftTexture
            } else if self.node.zRotation < -0.1 {
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
