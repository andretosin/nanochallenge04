//
//  BGView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 15/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import SwiftUI

struct BGView: View {
    
    var body: some View {
            Rectangle()
                .overlay(LinearGradient(gradient: Gradient(colors: [Color("TopYellow"), Color("LowYellow")]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}
