//
//  TriggerButtonView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 22/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SwiftUI

struct TriggerButtonView: View {
    @State private var showButtons = false
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Group {
                Button(action: { self.showButtons.toggle()
                }) {
                    Image(systemName: "bag.badge.plus")
                        .padding(24) .rotationEffect(Angle.degrees(showButtons ? 0 : -90))
                    
                }
                .background(Circle().fill(Color.green).shadow(radius: 8, x: 4, y: 4))
                .offset(x: 0, y: showButtons ? -150 : 0)
                .opacity(showButtons ? 1 : 0)
                Button(action: { self.showButtons.toggle() }) {
                    Image(systemName: "gauge.badge.plus")
                        .padding(24)
                        .rotationEffect(Angle
                            .degrees(showButtons ? 0 : 90))
                    
                }
                .background(Circle()
                .fill(Color.green)
                .shadow(radius: 8, x: 4, y: 4))
                .offset(x: showButtons ? -110 : 0, y: showButtons ? -110 : 0)
                .opacity(showButtons ? 1 : 0)
                Button(action: { self.showButtons.toggle() }) {
                    Image(systemName: "calendar.badge.plus")
                        .padding(24)
                        .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                    
                }
                .background(Circle()
                .fill(Color.green)
                .shadow(radius: 8, x: 4, y: 4))
                .offset(x: showButtons ? -150 : 0, y: 0)
                .opacity(showButtons ? 1 : 0)
                Button(action: { self.showButtons.toggle() }) {
                    Image(systemName: "plus")
                        .padding(24)
                        .rotationEffect(Angle.degrees(showButtons ? 45 : 0))
                    
                }
                .background(Circle()
                .fill(Color.green)
                .shadow(radius: 8, x: 4, y: 4))
                
            }
            .padding(.trailing, 20)
            .accentColor(.white)
            .animation(.default)
            
        }
    }
}

struct TriggerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TriggerButtonView()
    }
}
