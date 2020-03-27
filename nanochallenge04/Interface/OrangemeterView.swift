//
//  OrangemeterView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 26/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SwiftUI

struct OrangemeterView: View {
    var body: some View {
        GeometryReader { goma in
            ZStack {
                Image("OrangemeterFull")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/4)
                    .opacity(0.5)
                Image("Goma1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/12)
                    .offset(x: 0.045 * goma.size.width, y: -0.06 * goma.size.width)
                Image("Goma2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/12)
                    .offset(x: 0.0625 * goma.size.width)
                Image("Goma3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/12.7)
                    .offset(x: 0.042 * goma.size.width, y: 0.06 * goma.size.width)
                Image("Goma4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/13.1)
                    .offset(x: -0.046 * goma.size.width, y: 0.06 * goma.size.width)
                Image("Goma5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/12)
                    .offset(x: -0.0625 * goma.size.width)
                Image("Goma6")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/12)
                    .offset(x: -0.045 * goma.size.width, y: -0.06 * goma.size.width)
            }
        }
    }
}

struct OrangemeterView_Previews: PreviewProvider {
    static var previews: some View {
        OrangemeterView()
    }
}
