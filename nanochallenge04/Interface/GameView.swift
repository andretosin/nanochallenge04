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
    
    func makeCoordinator() -> GameView.Coordinator {
        return Coordinator(parent: self)
    }
    
    @Binding var isPlaying: Bool
    @Binding var lastDis: CGFloat
    @Binding var starsCollec: Int
    var isPadPlaying: Bool
    var isNoPadPlaying: Bool
    
    func makeUIViewController(context: Context) -> GameViewController {
        GameViewController()
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        if isPlaying {
            uiViewController.gameScene.play()
        } else {
            uiViewController.gameScene.endRun()
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
    
    class Coordinator: NSObject, GameDelegate {
        var parent: GameView
        
        init(parent: GameView) {
            self.parent = parent
        }
        
        
        func endRun(lastDistance: CGFloat, starsCollected: Int) {
            DispatchQueue.main.async {
                withAnimation {
                    self.parent.isPlaying = false
                    self.parent.lastDis = lastDistance
                    self.parent.starsCollec = starsCollected
                }
            }
        }
    }
}



