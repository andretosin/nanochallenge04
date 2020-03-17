//
//  ButtonConfView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 17/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SwiftUI

struct ButtonConfView: View {
    var body: some View {
        Button(action: {
            print("Conf button tapped!")
        }) {
            Image("RocketButt")
            .resizable()
            .scaledToFit()
                //                .font(.system(size: geo.size.width/14, weight: .black))
                //                .padding(.trailing, geo.size.width/40)
                .foregroundColor(.white)
            .padding(40)
                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 5)
                .background(Circle()

            .foregroundColor(Color("CosmicPurple"))
                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
            )
        }
    }
}

struct ButtonConfView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonConfView()
    }
}
