//
//  PopUpView.swift
//  nanochallenge04
//
//  Created by Rodolfo Diniz Biazi  on 31/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import SwiftUI

struct PopUpView: View {
    @Binding var showPopup: Bool
    var body: some View {
        ZStack {
            //            if self.showPopup {
            Color.black
                .opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture { self.showPopup = false }
            
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                Text("Oops... our bad")
                    .font(.custom("nulshock", size: 18))
                    .foregroundColor(Color("CosmicPurple"))
                    .bold()
                    .padding(.vertical, 10)
                    .offset(x: 15)
                    Spacer()
                    Button(action: {
                        self.showPopup = false
                        print("Close pop-up!")
                        //                                        self.showModal = true
                    }) {
                        HStack (spacing: 0) {
                            Image(systemName: "xmark.circle.fill")
                                                   .font(.system(size: 26, weight: .bold))
                                                   .foregroundColor(Color("CosmicPurple"))
                                                   .padding(.trailing, 10)
                        }

                    }
                    
                    
                   
                }
                
                .frame(maxWidth: .infinity)
                .background(Color.yellow)
                    Spacer()
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 70, weight: .bold))
                        .foregroundColor(Color("CosmicPurple"))
                    
                Spacer()
                Text("""
We're still working on this feature!
Come back later
""")
//                    .font(.custom("nulshock", size: 18))
                    .foregroundColor(Color("CosmicPurple"))
                    .bold()
                    .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                    .fixedSize()
                Spacer()
                Spacer()
                
//                Button("Close") {
//                    self.showPopup = false
//                }.padding(.bottom)
            }
            .frame(height: 300)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding(.horizontal, 25)
            //            }
        }
    }
}

//struct PopUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        PopUpView(showPopup: self.$showPopup)
//    }
//}
