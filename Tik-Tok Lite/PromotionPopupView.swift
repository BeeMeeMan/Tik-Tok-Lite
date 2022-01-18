//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//


import SwiftUI

struct PromotionPopupView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var selectedTab = 0
    var arrayView: [PopupViewModel]
    
    
    var body: some View {
        
        
        ZStack { // 1
            Color.black.ignoresSafeArea() // 2
            
            VStack {
                ZStack(){
                    Text("Month free")
                        .fontWeight(.black)
                        .foregroundColor(.roseColor)
                    
                    HStack{
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
                    
                }
                
                .padding(.top, 10)
             
                TabView(selection: $selectedTab) {
                    ForEach(0..<arrayView.count, id: \.self) { index in
                        ZStack{
                            VStack{
                                Spacer()
                                VStack{
                                    Image(arrayView[index].image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: arrayView[index].scale / 2)

                                }
                                Spacer()
                   
                                Text(arrayView[index].numberText)
                                .font(.system(size: 21, weight: .regular, design: .default))
                                .foregroundColor(Color.white)
                                .padding(.bottom, 5)
                                
                                Text(arrayView[index].instructionText).mainTextStyle
                                .padding(.bottom, 20)
                            
                     }
                        }
                        
                        .frame(width: UIScreen.main.bounds.width )
                    }
                    }
                    
                
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                .overlay(ThreeDotsIndexView(numberOfPages: arrayView.count, selectedTab: selectedTab), alignment: .bottom )
              
                .padding(.bottom, 45)
                
                Button(action: {
                    
                    if selectedTab != 2{
                        
                        selectedTab += 1
                        
                    } else {
                        closeTabView()
                    }
                })  {
                    HStack{
                        Image("Discount")
                        Text("Next")
                            .font(.system(size: 16, weight: .regular, design: .default))
                        
                    }
                }
                .roseButtonStyle()
                .padding(.bottom, 50)
                
                
            }
                
            }
            
        }
        
        
    
    
    func closeTabView(){
        presentationMode.wrappedValue.dismiss()
        
    }
    
    
}
    
    

