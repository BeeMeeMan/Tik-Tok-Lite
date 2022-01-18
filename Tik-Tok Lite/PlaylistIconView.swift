//
//  Playlist.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 21.12.2021.
//

import SwiftUI

struct PlaylistIconView: View {

    let plist: PlaylistData
    
    var body: some View {
        
        
        ZStack{
            
            Color.barBackgroundGrey
            HStack{
                
                ZStack{
                    
                    Image("CirclePhoto")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130, height: 130)
                        .shadow(color: Color.white, radius: 1, x: 0.5, y: 0.5)
                        .shadow(color: Color.white, radius: 1, x: -0.5, y: -0.5)
                }
                .padding(.horizontal, 10)
                
                
                VStack(alignment: .leading){
                    
                    Text("\(plist.name)")
                        .navigationTitleTextStyle
                        .padding(.top, 10)
                    //.frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    if let description = plist.description{
                        Text("\(description)")
                            .mainTextStyle
                            .multilineTextAlignment(.leading)
                        // .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                    
                }
                Spacer()
            }
            
        }
        .clipShape( RoundedRectangle(cornerRadius: 10))
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .padding(.horizontal, 5)
        .padding(.top, 5)
        
    }
    
}

