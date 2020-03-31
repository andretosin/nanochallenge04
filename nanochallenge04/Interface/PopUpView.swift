//
//  PopUpView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 31/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SwiftUI

struct PopUpView: View {
    @State private var showPopup = true
    var body: some View {
        
        ZStack {
            Color.black
                .opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            .onTapGesture { self.showPopup = false }
            VStack(spacing: 20) {
                Text("Oops... our bad")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                Spacer()
                Text("""
We are still working on this feature!
Come back later
""")
                Spacer()
                Button("Close") {
                    
                }.padding(.bottom)
            
            }
            .frame(height: 300)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding(.horizontal, 25)
            }
        
        
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView()
    }
}
