//
//  OrangemeterView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 26/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SwiftUI

struct PercentageIndicator: AnimatableModifier {
    var pct: CGFloat = 0
    
    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(ArcShape(pct: pct)
//                .fill(LinearGradient(gradient: Gradient(colors: [Color("LowYellow"), Color("TopYellow")]), startPoint: .top, endPoint: .bottom)))
                .foregroundColor(.red))
//            .overlay(LabelView(pct: pct))
//        .rotationEffect(.degrees(-90))
    }
    
    struct ArcShape: Shape {
        let pct: CGFloat
        
        func path(in rect: CGRect) -> Path {

            var p = Path()

            p.addArc(center: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0),
                     radius: rect.height / 2.1,
                     startAngle: .degrees(-90),
                     endAngle: .degrees(360.0 * Double(pct) - 90), clockwise: false)

            return p.strokedPath(.init(lineWidth: 2.9))
        }
    }
}

struct Indicator: View {
    var pct: CGFloat
    
    var body: some View {
        return Circle()
            .fill(Color.clear)
//            .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .modifier(PercentageIndicator(pct: self.pct))
    }
}

//struct MyButton: View {
//    let label: String
//    var font: Font = .title
//    var textColor: Color = .white
//    let action: () -> ()
//    
//    var body: some View {
//        Button(action: {
//            self.action()
//        }, label: {
//            Text(label)
//                .font(font)
//                .padding(10)
//                .frame(width: 70)
//                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.green).shadow(radius: 2))
//                .foregroundColor(textColor)
//            
//        })
//    }
//}

struct OrangemeterView: View {
    @State var percent: CGFloat = 0
    
    var slices: Int = 0
    var body: some View {
        GeometryReader { goma in
            ZStack {
//                Image("OrangemeterFull")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: goma.size.width/4)
//                    .opacity(0.5)
                Image("Circle")
                .resizable()
                .scaledToFit()
                .frame(width: goma.size.width/4)
                .overlay(Indicator(pct: self.percent))
                .opacity(0.15)
                Image("Goma1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/12.9)
                    .offset(x: 0.044 * goma.size.width, y: -0.06 * goma.size.width)
                    .opacity(self.slices >= 1 ? 1.0 : 0.15)
                Image("Goma2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/12)
                    .offset(x: 0.0625 * goma.size.width)
                    .opacity(self.slices >= 2 ? 1.0 : 0.15)
                    
                Image("Goma3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/12.7)
                    .offset(x: 0.042 * goma.size.width, y: 0.06 * goma.size.width)
                    .opacity(self.slices >= 3 ? 1.0 : 0.15)
                Image("Goma4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/13.1)
                    .offset(x: -0.046 * goma.size.width, y: 0.06 * goma.size.width)
                    .opacity(self.slices >= 4 ? 1.0 : 0.15)
                Image("Goma5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/12)
                    .offset(x: -0.064 * goma.size.width)
                    .opacity(self.slices >= 5 ? 1.0 : 0.15)
//                .opacity(0.15)
                Image("Goma6")
                    .resizable()
                    .scaledToFit()
                    .frame(width: goma.size.width/12.8)
                    .offset(x: -0.044 * goma.size.width, y: -0.06 * goma.size.width)
                    .opacity(self.slices >= 6 ? 1.0 : 0.15)
//                .opacity(0.15)
            }
        }
    }
}

struct OrangemeterView_Previews: PreviewProvider {
    static var previews: some View {
        OrangemeterView(slices: 5)
    }
}
