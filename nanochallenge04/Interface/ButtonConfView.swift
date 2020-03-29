//
//  ButtonConfView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 17/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SwiftUI

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)

    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)

    static let lightStart = Color(red: 60 / 255, green: 160 / 255, blue: 240 / 255)
    static let lightEnd = Color(red: 30 / 255, green: 80 / 255, blue: 120 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct ColorfulBackground<S: Shape>: View {
    var isHighlighted: Bool
    var shape: S
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(Color("LowerPurple"))
//                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
//                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: 1, y: -1)
//                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                .shadow(color: Color("CosmicPurple").opacity(0.75), radius: 2, x: -2, y: 2)
            } else {
                shape
                    .fill(Color("CosmicPurple"))
//                    .overlay(shape.stroke(LinearGradient(Color.lightStart, Color.lightEnd), lineWidth: 4))
//                    .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
//                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
                   .shadow(color: Color("CosmicPurple").opacity(0.75), radius: 2, x: -2, y: 2)
            }
        }
    }
}

struct ColorfulToggleStyle: ToggleStyle {
    @State var showDetails = false
    var showSkins: () -> Void
    
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: {
            print("Button is clicked")
            configuration.isOn.toggle()
            self.showDetails.toggle()
            print("showDetailsTogged")
            self.showSkins()
        }) {
            
            configuration.label
                .padding(10)
                .contentShape(Circle())
        }
        .background(
            ColorfulBackground(isHighlighted: configuration.isOn, shape: Circle())
        )
    }
}

class ButtonType: Identifiable {
    var iconName: String
    
    init(iconName: String) {
        self.iconName = iconName
    }
}

struct ButtonConfView: View {
    
    @State public var content: ButtonType
    @State private var isToggled = false
    var buttonAction: () -> Void = {}
    var body: some View {
            Toggle(isOn: self.$isToggled) {
                    Image("\(self.content.iconName)")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.white)
                }
            .toggleStyle(ColorfulToggleStyle(showSkins: buttonAction))
        }
}

struct ButtonConfView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonConfView(content: ButtonType(iconName: "RocketButt"), buttonAction: {})
    }
}
