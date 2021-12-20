//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//


import SwiftUI

struct PlayListsView : View {
    
    @Environment(\.presentationMode) var PlayListPresentationMode
    
    var body: some View {
        
        NavigationView{
            
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
                    NavigationLink(destination:
                        
                                    PListCreator()
                        
                    ){
                        HStack{
                            Image(systemName: "star.fill")
                                .frame(width: 20, height: 20, alignment: .center)
                                .foregroundColor(.white)
                            Text("Create playlist")
                                .font(.system(size: 16, weight: .regular, design: .default))
                        }
                    }
                    .roseButtonStyle()
                    .padding(.bottom, 50)
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Image("EditSquare").foregroundColor(.roseColor))
            .navigationTitle("Playlists")
            .font(.system(size: 16, weight: .regular, design: .default))
            
        }
    }
    
}

