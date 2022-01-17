//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI

struct IntroTabView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var selectedTab = 0
    @State private var arrayView = [
        LayoutTabView(image: "IntroPhone1", numberText: "Step #1", instructionText: "In the Tik-Tok application, click “Share” button on the video you like", imageOffsetX: 20, imageScale: 0.3),
        LayoutTabView(image: "IntroPhone2", numberText: "Step #2", instructionText: "In the drop-down menu - click the \"Link\" button", imageOffsetX: 20, imageScale: 0.1),
        LayoutTabView(image: "IntroPhone3", numberText: "Step #3", instructionText: "Return to our application and click \"Download Clip\"", imageOffsetX: 20, imageScale: 0.3),
        
    ]
    
    // var of first start of the app
   
    
    
    
    var body: some View {
        
        
//        ZStack { // 1
//            Color.black.ignoresSafeArea() // 2
            
            VStack {
                HStack(){
                  
                    
                    Spacer()
                    Button(action: {
                        
                        closeTabView()
                        
                    } ){
                        
                        Image("CloseX")
                            .frame(width: 30, height: 30).background(Color.black)
                            .padding(.trailing, 28)
                                                
                            }
                    .closeButtonStyle()
                    
                }
                
                .padding(10)
               
                TabView(selection: $selectedTab) {
                    ForEach(0..<arrayView.count, id: \.self) { index in
                        arrayView[index]
                    }
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                .overlay(ThreeDotsIndexView(numberOfPages: arrayView.count, selectedTab: selectedTab), alignment: .bottom )
              //  .animation(.default)
                .padding(.bottom, 45)
                
                Spacer()
                
                Button(action: {
                    
                    if selectedTab != 2{
                        
                        selectedTab += 1
                        
                    } else {
                        closeTabView()
                    }
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
           
      //  }
      
        
        
    }
    
    func closeTabView(){
        presentationMode.wrappedValue.dismiss()
        
    }
    
    
}
    
    


