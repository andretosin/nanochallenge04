//
//  ButtonConfView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 17/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SwiftUI

class ButtonType: Identifiable {
    var iconName: String

    init(iconName: String) {
        self.iconName = iconName
    }
}

struct ButtonConfView: View {
    
     @State public var content: ButtonType
    
    var body: some View {
        GeometryReader { geo3 in
        Button(action: {
            print("Conf button tapped!")
        }) {
            Image("\(self.content.iconName)")
//            Image("RocketButtt")

            .resizable()
            .scaledToFit()
            .padding(8)
//                .frame(width: geo3.size.width/2, height: geo3.size.width/2)
                

                //                .font(.system(size: geo.size.width/14, weight: .black))
                //                .padding(.trailing, geo.size.width/40)
                .foregroundColor(.white)
                //                .padding(40)
//                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 5)
                .background(Circle()
//                    .padding()
                    .foregroundColor(Color("CosmicPurple"))
                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
//                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
//                    .padding(20)
                    
            )
        }
    }
    }
}

struct ButtonConfView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonConfView(content: ButtonType(iconName: "RocketButt"))
    }
}
