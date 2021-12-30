//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//


import SwiftUI


struct PlayListsView : View {
    
    @Environment(\.presentationMode) var PlayListPresentationMode
    @EnvironmentObject var downloader: Downloader
    
    init(){
       
        
    }
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                Color.black
                if downloader.plistArr.isEmpty {
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
                        
                                    PListCreatorView()
                        
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
                    
                } else {
                    
                    ScrollView {
                        LazyVStack() {
                                    ForEach(downloader.plistArr, id: \.self) { plist in
                                        NavigationLink(destination: PlayListVideoListView(plist: plist)){
                                            PlistRow(plist: plist)
                                        }
                                       
                                }
                            }

                }
                    .padding(.top, 10)
                
                }
               
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: addPlistButton)
            .navigationTitle("Playlists")
            .font(.system(size: 16, weight: .regular, design: .default))
            
        }
    }
    
    //MARK: addPlistButton
    
    var addPlistButton: some View {
        
        NavigationLink(destination:
            
                        PListCreatorView()
            
        ){
            Image("Plus").foregroundColor(.roseColor)
        }
    }
    
    
    struct PlistRow: View {
        
        let plist: Playlist

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
    
}


extension Image {
    func asThumbnail(withMaxWidth maxWidth: CGFloat = 100) -> some View {
        resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: maxWidth)
    }
}
