//
//  GameView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 14/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import SwiftUI
import Foundation

struct GameView: UIViewControllerRepresentable {
    
    func makeCoordinator() -> GameView.Coordinator {
        return Coordinator(parent: self)
    }
    
    @Binding var isPlaying: Bool
    @Binding var lastDis: CGFloat
    @Binding var starsCollec: Int
    @Binding var highscore: CGFloat
    @Binding var totalStars: Int
    @Binding var showText: Bool
    @Binding var shipIndex: Int
    
    func makeUIViewController(context: Context) -> GameViewController {
        GameViewController(gameDelegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        if isPlaying {
            uiViewController.gameScene.startRun(totalStars: totalStars)
        } else {
            uiViewController.gameScene.endRun()
        }
        
        if shipIndex == 1 {
            uiViewController.gameScene.player.setSkin(index: 2)
        }
        if shipIndex == 2 {
            uiViewController.gameScene.player.setSkin(index: 1)
        }
        
      
        
    }
    
    class Coordinator: NSObject, GameDelegate {
        
        
        var parent: GameView
        
        init(parent: GameView) {
            self.parent = parent
        }
        
        
        func updateLabels(flightDistance: String, currentScore: String) {
            
        }
        
        func endRun(lastDistance: CGFloat, starsCollected: Int, totalStars: Int) {
            DispatchQueue.main.async {
                withAnimation {
                    
                    let defaults = UserDefaults.standard
                    let highscore = defaults.value(forKey: "highscore") as! CGFloat
                    
                    
                    self.parent.isPlaying = false
                    self.parent.lastDis = lastDistance
                    self.parent.starsCollec = starsCollected
                    if self.parent.lastDis > highscore {
                        self.parent.highscore = self.parent.lastDis
                        defaults.set(self.parent.lastDis, forKey: "highscore")
                    } else {
                        self.parent.highscore = highscore
                    }
                    self.parent.totalStars = totalStars
                    if self.parent.lastDis == 0 && self.parent.starsCollec == 0 {
                        self.parent.showText = false
                    } else {
                        self.parent.showText = true
                    }
                }
            }
        }
    }
}



