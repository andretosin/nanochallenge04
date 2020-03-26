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
        Image("Goma1")
        .resizable()
        .scaledToFit()
            .frame(width: goma.size.width/12)
            
            }
        }
    }
}

struct OrangemeterView_Previews: PreviewProvider {
    static var previews: some View {
        OrangemeterView()
    }
}
