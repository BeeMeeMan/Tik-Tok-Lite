//
//  IntroTabView.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 10/27/21.
//

import SwiftUI


struct LayoutTabView: View {
    
    //(intro image: String, step numberText: String, instruction text: String) {
    
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
            Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: scale / 2)
//             .resizable()
////              .offset(x: imageOffsetX, y: 0)
//                              .scaledToFill() // <=== Saves aspect ratio
//                            .frame(width: scale * imageScale,  alignment: .bottom)
//                               .scaleEffect(imageScale, anchor: .center)
////
                .padding(.bottom, 30)
                
       //     }
               
    //    VStack{
            
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
    
    func moveToScreen(screen id: String,_ proxyReader: ScrollViewProxy){
        withAnimation(.spring()) {
            proxyReader.scrollTo(id, anchor: .top)
        }
    }
    
}



