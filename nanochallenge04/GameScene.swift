//
//  GameScene.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 04/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: Player!
    var background: GameBackground!
    var collisionFlag = false
    var rollRate: CGFloat!
    
    var lastTime: TimeInterval = TimeInterval(0)
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        

        
        let playerNode = self.childNode(withName: "player") as! SKSpriteNode
        playerNode.zPosition = 1
        player = Player(scene: self, node: playerNode)
        
        // swipe setup
        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector(("swipedRight")))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector(("swipedLeft")))
        swipeRight.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        self.rollRate = self.player.rollRate
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        player.update(CGFloat(deltaTime))
        if abs(player.node.position.x) < 5 {
            collisionFlag = false
            print("saiu")

        }
    }
    
    // MARK: - ContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        if !collisionFlag {
            player.resetPos = true
            print("entrou")
            collisionFlag = true
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        if collisionFlag {
            
//            collisionFlag = false
        }
    }

    // MARK: - Swipe methods

    @objc func swipedRight() {

        player.rollLeft(rollRate)
    }
    
    @objc func swipedLeft() {

        player.rollRight(rollRate)
    }
    
    
    // MARK: - Touch methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}
