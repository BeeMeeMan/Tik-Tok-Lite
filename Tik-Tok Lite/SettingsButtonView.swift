//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI

struct SettingsButtonView: View, Hashable{
       
    let buttonImage: String
    let buttonText: String
    
   
    
   // @State private var showingView = false
    
    
    var body: some View {
        
//        Button(action: {
//
//            showingView = true
//
//        })  {
            VStack{
                HStack{
                    
                    Image(buttonImage)
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(.white)
                        .padding(.trailing, 20)
                        
                    Text(buttonText)
                        .settingsTextStyle
                        
                    
                    Spacer()
                    Image("ArrowRightCircle")
                    
                }
                .padding(.bottom, 2)
                
                HStack{
                    
                    Spacer()
                    Color.white.frame(width: UIScreen.width * 0.80, height:CGFloat(1) / UIScreen.main.scale, alignment: .trailing)
                    // .padding(.trailing, 16)
                }
            }
            .frame(width: UIScreen.width * 0.931, height: 30, alignment: .top)
      //  }
        
        
    }
    
}
