//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI

struct TestPopUp: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var selectedTab = 0
    @State private var arrayView = [
        LayoutTabView(image: "IntroPhone1", numberText: "Step #1", instructionText: "In the Tik-Tok application, click “Share” button on the video you like", imageOffsetX: 20, imageScale: 0.3),
        LayoutTabView(image: "IntroPhone2", numberText: "Step #2", instructionText: "In the drop-down menu - click the \"Link\" button", imageOffsetX: 20, imageScale: 0.1),
        LayoutTabView(image: "IntroPhone3", numberText: "Step #3", instructionText: "Return to our application and click \"Download Clip\"", imageOffsetX: 20, imageScale: 0.3),
        
    ]
    
    
    var body: some View {
        
        
        ZStack { // 1
            Color.green
                .ignoresSafeArea()
                .opacity(0.1)
                
            
            VStack {
            
                Spacer()
                
                Button(action: {
                    
                        closeTabView()
                   
                })  {
                    HStack{
                        Text("Next")
                            .font(.system(size: 16, weight: .regular, design: .default))
                        Image("ArrowRight")
                            .frame(width: 20, height: 20, alignment: .center)
                    }
                }
                .roseButtonStyle()
                // .buttonStyle(ActionButtonStyle())
                .padding(.bottom, 50)
                
                
                
                
            }
            
        }
        
        
    }
      
  
    
 
    func closeTabView(){
        presentationMode.wrappedValue.dismiss()
        
    }
    
    
}
    
    

struct TestPopUp_Previews: PreviewProvider {
    static var previews: some View {
       DownloadView()
    }
}
