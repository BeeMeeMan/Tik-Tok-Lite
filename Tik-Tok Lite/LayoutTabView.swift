//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI


struct LayoutTabView: View {
 
    let image: String
    let numberText: String
    let instructionText: String
    let imageOffsetX: CGFloat
    let imageScale: CGFloat
    let scale = UIScreen.main.bounds.width
    
    var body: some View {
        
        ZStack{
            VStack{
                Spacer()
                VStack{
            Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: scale / 2)

                }
                Spacer()
   
            Text(numberText)
                .font(.system(size: 21, weight: .regular, design: .default))
                .foregroundColor(Color.white)
                .padding(.bottom, 5)
                
            Text(instructionText).mainTextStyle
                .padding(.bottom, 20)
            
     }
        }
        
        .frame(width: UIScreen.main.bounds.width )
    }

}



