//
//  GameScene.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 04/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player: Player!
    
    var lastTime: TimeInterval = TimeInterval(0)
    
    override func didMove(to view: SKView) {
        let playerNode = self.childNode(withName: "player") as! SKSpriteNode
        player = Player(scene: self, node: playerNode)
        
        
        // swipe setup
        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector(("swipedRight")))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector(("swipedLeft")))
        swipeRight.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastTime == 0 {
            lastTime = currentTime
            return
        }
        let deltaTime = currentTime - lastTime
        
        player.update(CGFloat(deltaTime))

    }
    
    @objc func swipedRight() {
        player.rollLeft()
    }
    
    @objc func swipedLeft() {
        player.rollRight()
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}
