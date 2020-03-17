//
//  GameView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 14/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import SwiftUI

struct GameView: UIViewControllerRepresentable {
    var isPlaying: Bool
    var isPadPlaying: Bool
    var isNoPadPlaying: Bool
    
    func makeUIViewController(context: Context) -> GameViewController {
        GameViewController()
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        if isPlaying {
            uiViewController.gameScene.play()
        } else {
            uiViewController.gameScene.pause()
        }
        
        if isPadPlaying {
            uiViewController.gameScene.playPad()
        } else {
            uiViewController.gameScene.stopPad()
        }
        
        if isNoPadPlaying {
            uiViewController.gameScene.playNoPad()
        } else {
            uiViewController.gameScene.stopNoPad()
        }
        
        
    }
}
