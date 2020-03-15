//
//  MenuView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 14/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SwiftUI


struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct MenuView: View {
    
    @State private var buttonIsShown = true
    @State private var showLogo = false
    @State private var showLastScore = true
    @State private var started = false
    @State private var isPlaying = false
    @State private var topMenu: CGFloat = 0
    
    var body: some
        View {
        ZStack {
            BGView()
            GeometryReader { geo in
                ZStack {
                    VStack {
                        HStack {
                            ZStack {
                                HStack {
                                    Image(systemName: "flag.fill")
                                        .font(.system(size: geo.size.width/22))
                                        .foregroundColor(.white)
                                        .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                    HStack (spacing: geo.size.width/120) {
                                        Text("342")
                                            .font(.custom("nulshock", size: geo.size.width/18))
                                            .foregroundColor(.white)
                                            .bold()
                                            .multilineTextAlignment(.leading)
                                            .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                        Text("ly")
                                            .font(.custom("Audiowide-Regular", size: geo.size.width/30))
                                            .foregroundColor(.white)
                                            .bold()
                                            .padding(.top, geo.size.width/60)
                                            .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                    }
                                }
                                .padding(.leading, 20)
                                .padding(.trailing, 15)
                                .padding(.vertical, 10)
                                    
                                .background(Capsule()
                                .fill(Color("CosmicPurple")
                                    )
                                )
                                    .padding(.leading, 20)
                                    .frame(height: geo.size.height/10, alignment: .leading)
                                    .clipShape(Capsule())
                                    .shadow(color: Color.black.opacity(0.4), radius: 4, x: 2, y: 0)
                            }
                            Spacer()
                            ZStack (alignment: .trailing) {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: geo.size.width/22, weight: .bold))
                                        .foregroundColor(.white)
                                        .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                    Text("009")
                                        .font(.custom("nulshock", size: geo.size.width/18))
                                        .foregroundColor(.white)
                                        .bold()
                                        .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                }
                                .padding(.trailing, 20)
                                .padding(.leading, 15)
                                .padding(.vertical, 10)
                                    
                                .background(Capsule()
                                .fill(Color("CosmicPurple")
                                    )
                                )
                                    .padding(.trailing, geo.size.width/10)
                                    .shadow(color: Color.black.opacity(0.4), radius: 4, x: 2, y: 0)
                                    .clipShape(Capsule())
                                    .background(Capsule()
                                        .fill(Color("LowerPurple"))
                                        .shadow(color: Color.black.opacity(0.4), radius: 4, x: 0, y: 2)
                                )
                                VStack (alignment: .trailing) {
                                    Button(action: {
                                        print("Store button tapped!")
                                    }) {
                                        Image(systemName: "plus")
                                            .font(.system(size: geo.size.width/14, weight: .black))
                                            .padding(.trailing, geo.size.width/40)
                                            .foregroundColor(.white)
                                            .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                    }
                                }
                            }
                            .frame(height: geo.size.height/10, alignment: .trailing)
                        }
                        .padding(.trailing, 20)
                        .overlay(
                            GeometryReader { geo2 in
                                Color.clear
                                    .onAppear {
                                        self.topMenu = geo2.frame(in: .global).height
                                        print("lala", self.topMenu)
                                }
                            }
                        )
                        VStack (spacing: geo.size.width/100) {
                            ZStack {
                                if self.showLogo {
                                    Image("appollo")
                                        .resizable()
                                        .padding()
                                        .scaledToFit()
                                        .frame(width: geo.size.width/1.3)
                                }
                                HStack (spacing: geo.size.width/120) {
                                    VStack {
                                        VStack (spacing: 0) {
                                            HStack (spacing: 0) {
                                                Text("243")
                                                    .font(.custom("nulshock", size: geo.size.width/5))
                                                    .foregroundColor(Color("CosmicPurple"))
                                                    .bold()
                                                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                                    .padding(.top, geo.size.width/60)
                                                    .fixedSize(horizontal: true, vertical: false)
                                                Text("ly")
                                                    .font(.custom("Audiowide-Regular", size: geo.size.width/12))
                                                    .foregroundColor(Color("CosmicPurple"))
                                                    .bold()
                                                    .padding(.top, geo.size.width/10)
                                                    .frame(width: geo.size.width/10)
                                            }.offset(x: geo.size.width/20)
                                            HStack {
                                                Image(systemName: "star.fill")
                                                    .font(.system(size: geo.size.width/15, weight: .bold))
                                                    .foregroundColor(Color("CosmicPurple"))
                                                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                                Text("13")
                                                    .font(.custom("nulshock", size: geo.size.width/10))
                                                    .foregroundColor(Color("CosmicPurple"))
                                                    .bold()
                                                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                                    .fixedSize(horizontal: true, vertical: false)
                                            }
                                            .offset(x: -geo.size.width/20)
                                        }
                                    }
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                            }
                        }
                        Spacer()
                    }
                    GameView(isPlaying: self.isPlaying)
                        .mask(
                            ZStack {
                                Circle()
                                    .offset(y: self.topMenu/2)
                                    .padding(self.isPlaying ? -geo.size.height : geo.size.width/10)
                                //                                .padding(.top, 20)
                                Circle()
                                    .offset(y: 2.4 * self.topMenu)
                                    .padding(self.isPlaying ? -geo.size.height : geo.size.width/3.2)
                                //                                .padding(100)
                                //                                    .padding(geo.size.width/120)
                            }
                    )
                    Circle()
                        .offset(y: 2.4 * self.topMenu)
                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                    .foregroundColor(Color("LowerPurple"))
                        .frame(width: geo.size.width/3.4)
                        .opacity(self.buttonIsShown ? 1.0 : 0.0)
                                               .onTapGesture {
                                                   withAnimation {
                                                       self.isPlaying = true
                                                       self.buttonIsShown.toggle()
                                                   }
                                           }
                        

                        Triangle()
                        .fill(Color.white)
                            .offset(x: 2.4 * self.topMenu, y: -0.1 * self.topMenu)
                            .shadow(color: Color.black.opacity(0.5), radius: 4, x: 6, y: 1)
                            .frame(width: geo.size.width/5.5, height: geo.size.width/7)
                            .rotationEffect(.degrees(-270))
                            .padding(30)
//                    Image(systemName: "arrowtriangle.right.fill")
//                        .font(.system(size: geo.size.width/6))
//                        .foregroundColor(.white)
//                        .shadow(color: Color.black.opacity(0.5), radius: 4, x: 1, y: 6)
//
//                        .padding(30)
                        .opacity(self.buttonIsShown ? 1.0 : 0.0)
                        .onTapGesture {
                            withAnimation {
                                self.isPlaying = true
                                self.buttonIsShown.toggle()
                            }
                    }
//                    .background(Circle()
//
//                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
//                    .foregroundColor(Color("LowerPurple")
//                        )
                    
                }
            }
        }
//                .edgesIgnoringSafeArea(.all)
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            MenuView()
////                                    ContentView()
////                                        .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
////                                        .previewDisplayName("iPhone SE")
////
////                                    ContentView()
////                                        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
////                                        .previewDisplayName("iPhone 8")
//        }
//    }
//}

