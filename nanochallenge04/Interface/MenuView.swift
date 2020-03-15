//
//  MenuView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 14/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SwiftUI

//
//  ContentView.swift
//  CosmicRush
//
//  Created by APPLE DEVELOPER ACADEMY on 13/03/20.
//  Copyright © 2020 Rodolfo Diniz. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    @State private var showLogo = false
    @State private var showLastScore = true
    @State private var started = false
    
    var body: some View {
        ZStack {
            //            Rectangle()
            //                .fill(Color.blue)
            //                .foregroundColor(.red)
            //
            Rectangle()
                .overlay(LinearGradient(gradient: Gradient(colors: [Color("TopYellow"), Color("LowYellow")]), startPoint: .top, endPoint: .bottom))
            GeometryReader { geo in
                ZStack {
                    VStack {
                        HStack {
                            ZStack {
                                HStack {
                                    Image(systemName: "flag.fill")
                                        .font(.system(size: geo.size.width/22))
                                        //                                        .font(Font.system(.headline).weight(.bold))
                                        .foregroundColor(.white)
                                        .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                    
                                    HStack (spacing: geo.size.width/120) {
                                        Text("342")
                                            .font(.custom("nulshock", size: geo.size.width/18))
                                            //                                        .font(.system(.headline))
                                            .foregroundColor(.white)
                                            .bold()
                                            .multilineTextAlignment(.leading)
                                            .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                        
                                        Text("ly")
                                            .font(.custom("Audiowide-Regular", size: geo.size.width/30))
                                            
                                            //                                        .font(.system(.headline))
                                            .foregroundColor(.white)
                                            .bold()
                                            .padding(.top, geo.size.width/60)
                                            .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                    }
                                    //                                        .baselineOffset(-10)
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
                                
                                //                                Capsule()
                                //
                                //
                                //
                                //                                    .fill(Color("LowerPurple"))
                                //                                    .padding()
                                //                                    //                .frame(width: 200)
                                //                                    .frame(width: geo.size.width/2, height: geo.size.height/10)
                                //                                    .shadow(color: Color.black.opacity(0.4), radius: 4, x: 0, y: 2)
                                //                                Capsule()
                                //
                                //                                    .fill(Color("CosmicPurple"))
                                //                                    .padding(.vertical, 20)
                                //                                    //                .frame(width: 200)
                                //                                    .frame(width: geo.size.width/2.6, height: geo.size.height/10)
                                HStack {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: geo.size.width/22, weight: .bold))
                                        
                                        //                                        .font(Font.system(.headline).weight(.bold))
                                        .foregroundColor(.white)
                                        .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                    
                                    Text("009")
                                        .font(.custom("nulshock", size: geo.size.width/18))
                                        .foregroundColor(.white)
                                        .bold()
                                        .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                    
                                    //                                        .multilineTextAlignment(.leading)
                                    
                                    //                                                                                .frame(alignment: .leading)
                                }
                                    
                                    
                                .padding(.trailing, 20)
                                .padding(.leading, 15)
                                .padding(.vertical, 10)
                                    
                                .background(Capsule()
                                .fill(Color("CosmicPurple")
                                    )
                                )
                                    .padding(.trailing, geo.size.width/10)
                                    //                                        .frame(alignment: .trailing)
                                    //                                        .frame(width: geo.size.width/2.2, height: geo.size.height/10, alignment: .trailing)
                                    
                                    .shadow(color: Color.black.opacity(0.4), radius: 4, x: 2, y: 0)
                                    
                                    .clipShape(Capsule())
                                    .background(Capsule()
                                        
                                        
                                        .fill(Color("LowerPurple"))
                                        //                                             .frame(alignment: .leading)
                                        //                                .padding()
                                        //                .frame(width: 200)
                                        //                                .frame(width: geo.size.width/2, height: geo.size.height/10)
                                        .shadow(color: Color.black.opacity(0.4), radius: 4, x: 0, y: 2)
                                )
                                
                                //
                                VStack (alignment: .trailing) {
                                    //                                    VStack {
                                    Button(action: {
                                        print("Store button tapped!")
                                    }) {
                                        Image(systemName: "plus")
                                            .font(.system(size: geo.size.width/14, weight: .black))
                                            
                                            .padding(.trailing, geo.size.width/40)
                                            //                                                .weight(.bold))
                                            .foregroundColor(.white)
                                            .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                    }
                                    
                                    
                                    
                                    
                                    //                                        .clipShape(Capsule())
                                }
                            }
                            .frame(height: geo.size.height/10, alignment: .trailing)
                            //                            .padding(.vertical, 20)
                            //                                .padding(.trailing, 20)
                        }
                            
                            //                        .padding(.vertical, 30)
                            .padding(.top, 40)
                            .padding(.trailing, 20)
                        VStack (spacing: geo.size.width/100) {
                            ZStack {
                                if self.showLogo {
                                    Image("appollo")
                                        .resizable()
                                        .padding()
                                        .scaledToFit()
                                        .frame(width: geo.size.width/1.3)
                                }
                                
                                //                            Spacer()
                                HStack (spacing: geo.size.width/120) {
                                    VStack {
                                        VStack (spacing: 0) {
                                            HStack (spacing: 0) {
                                                Text("242")
                                                    .font(.custom("nulshock", size: geo.size.width/5))
                                                    .foregroundColor(Color("CosmicPurple"))
                                                    .bold()
                                                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                                .padding(.top, geo.size.width/60)
                                                Text("ly")
                                                    .font(.custom("Audiowide-Regular", size: geo.size.width/12))
                                                    .foregroundColor(Color("CosmicPurple"))
                                                    .bold()
                                                    .padding(.top, geo.size.width/10)
//                                                   .padding(.trailing, geo.size.width/2)
                                                    .frame(width: geo.size.width/10)
                                                
                                            }.offset(x: geo.size.width/20)
                                            
                                            HStack {
                                                //                                            HStack {
                                                Image(systemName: "star.fill")
                                                    .font(.system(size: geo.size.width/15, weight: .bold))
                                                    
                                                    //                                        .font(Font.system(.headline).weight(.bold))
                                                    .foregroundColor(Color("CosmicPurple"))
                                                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                                    .offset(x: -geo.size.width/9)
//                                                .frame(width: geo.size.width/10)
                                                //                                                }
                                                
                                                Text("513")
                                                    .font(.custom("nulshock", size: geo.size.width/10))
                                                    .foregroundColor(Color("CosmicPurple"))
                                                    .bold()
                                                    .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                                }
//                                            .offset(x: geo.size.width/20)
                                                
                                                //                                        .multilineTextAlignment(.leading)
                                                
                                                //                                                                                .frame(alignment: .leading)
                                            
                                        }
                                    }
                                    //                                                                        Text("ly")
                                    //                                                                            .font(.custom("Audiowide-Regular", size: geo.size.width/12))
                                    //
                                    //                                                                            //                                        .font(.system(.headline))
                                    //                                                                            .foregroundColor(Color("CosmicPurple"))
                                    //                                                                            .bold()
                                    //                                    //                                        .shadow(color: Color.black.opacity(0.75), radius: 1, x: -1, y: 1)
                                    //                                                                        .fixedSize(horizontal: true, vertical: false)
                                    //                                                                        .padding(.top, geo.size.width/12)
                                    //
                                    //                                                                                                                .baselineOffset(-10)
                                }
                                    
                                .frame(minWidth: 0, maxWidth: .infinity)
                                
                            }
                            
                            //                            Spacer()
                        }
                        //                        .frame(height: geo.size.height/2)
                        
                        
                        
                        //                            .padding(40)
                        //                        HStack {
                        //                        Circle()
                        //                            Circle()
                        //                            Circle()
                        //                            Circle()
                        //                        }
                        //                    .padding()
                        //                        HStack {
                        //                            ConfButtonView()
                        //                            ConfButtonView()
                        //                            ConfButtonView()
                        //                            ConfButtonView()
                        //                        }
                        //                        .frame(width: geo.size.width)
                        Spacer()
                    }
                    
                    //                    .scaleToFit()
                    //                    .frame(width: 200, height: 200)
                    //            }
                                        GameView()
//                                            .opacity(0.2)

                                            .mask(
                                                Circle()
                                                    .padding(self.started ? -geo.size.height : geo.size.width/20)

                                        )
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.blue)
                        .padding()
                        .onTapGesture {
                            withAnimation {
                                self.started.toggle()
                            }
                            //
                    }
                }
            }
            
        }
        .edgesIgnoringSafeArea(.all)
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

