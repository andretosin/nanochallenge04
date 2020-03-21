//
//  RocketView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 21/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SwiftUI
//var item = ["A", "A", "A", "A", "A"]

struct RocketView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 20) {
                ForEach(1..<10) { item in
                    GeometryReader { geoRocket in
                        Image("\("RocketOff 2")")
                                                    .rotationEffect(Angle(degrees: Double(geoRocket.frame(in: .global).minX))/30)
//                                                        .rotation3DEffect(Angle(degrees: Double(geoRocket.frame(in: .global).minX)), axis: (x: 0, y: 10.0, z: 0))
                    }
                }
            .frame(width: 200)
            .padding(20)
            }
        }
    }
}

struct RocketView_Previews: PreviewProvider {
    static var previews: some View {
        RocketView()
    }
}
