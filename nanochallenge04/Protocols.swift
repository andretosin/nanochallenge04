//
//  Protocols.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 06/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SpriteKit

protocol Updatable {
    func update(_ deltaTime: CGFloat)
}

protocol Spawnable {
    func update(_ currentTime: TimeInterval)
}


