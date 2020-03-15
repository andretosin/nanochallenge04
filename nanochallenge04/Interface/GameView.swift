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
    
    func makeUIViewController(context: Context) -> GameViewController {
        GameViewController()
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        if isPlaying {
            uiViewController.gameScene.play()
        } else {
            uiViewController.gameScene.pause()
        }
    }
}
