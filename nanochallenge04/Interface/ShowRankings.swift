////
////  ShowRankings.swift
////  nanochallenge04
////
////  Created by Rodolfo Diniz Biazi  on 01/04/20.
////  Copyright © 2020 Apple Developer Academy. All rights reserved.
////
//
//import SwiftUI
//import GameKit
//
//
//
//struct ShowRankings: View {
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//    let leaderBoard = GKLeaderboard()
//    @State var scores: [GKScore] = []
//    var body: some View {
//        VStack {
//            Button(action: {
//                self.updateLeader()
//            }) {
//                Text("Refresh leaderboard")
//            }
//            List(scores, id: \.self) { score in
//                Text("\(score.player.alias) \(score.value)")
//            }
//        }.onAppear() {
////            self.appDelegate.gameCenter.authenticateLocalPlayer()
//            self.updateLeader()
//        }
//    }
//    func updateLeader() {
//        let leaderBoard: GKLeaderboard = GKLeaderboard()
//        leaderBoard.identifier = "YOUR_LEADERBOARD_ID_HERE"
//        leaderBoard.timeScope = .allTime
//        leaderBoard.loadScores { (scores, error) in
//            if let error = error {
//                debugPrint("leaderboard loadScores error \(error)")
//            } else {
//                guard let scores = scores else { return }
//                self.scores = scores
//            }
//        }
//    }
//}
