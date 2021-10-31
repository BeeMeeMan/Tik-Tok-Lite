//
//  PlayListsView.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 10/29/21.
//

import SwiftUI

struct PlayListsView : View {
    
    @Environment(\.presentationMode) var PlayListPresentationMode
    
    var body: some View {
        ZStack{
            Color.black
            
            VStack{
                Spacer()
                Spacer()

                Spacer()
            Image("Play")
        
                .scaleEffect(1.6, anchor: .center)
            
            Text("Make your first playlist")
                    .mainTextStyle
                    .padding(.top, 50)
                Spacer()
                Button(action: {
                    
                    
                })  {
                    HStack{
                        Image(systemName: "star.fill")
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(.white)
                        Text("Make playlist")
                            .font(.system(size: 16, weight: .regular, design: .default))
                        
                    }
                }
                .roseButtonStyle()
                // .buttonStyle(ActionButtonStyle())
                .padding(.bottom, 50)
                
            }
        }
    }
    
//    func closeView(){
//        presentationMode.wrappedValue.dismiss()
//
//    }
}

//struct PlayListsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayListsView()
//    }
//}
