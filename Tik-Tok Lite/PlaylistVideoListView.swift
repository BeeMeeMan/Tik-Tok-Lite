//
//  PlayListVideoListView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 22.12.2021.
//

import SwiftUI
import AVKit
import AVFoundation

struct PlaylistVideoListView: View {
    
    //New modalView:
   // @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    @EnvironmentObject var downloader: Downloader
    @State private var showingPlayerView = false
    
    @State var plist: PlaylistData
    @State var showDownloadPopUpView = false
    @State var playlistArray: [Tiktok] = []
    @State var videoForPlay = ""
    
    var body: some View {
        
        VStack{
            
            
            if playlistArray.isEmpty {
                
                Image("Play")
                    .padding(5)
                Text("It's empty for now")
                    .montserrat16TextStyle
                    .padding(.bottom, 10)
                Text("Add video to playlist")
                    .montserrat16TextStyle
                    .foregroundColor(.white)
                
            } else {
                
                ScrollView {
                    LazyVStack() {
                        ForEach(playlistArray) { tiktok in
                            
                            //VideoFileRow(tiktok: arr[index])
                            tiktok.vImg
                                .onTapGesture {
                                    
                                    videoForPlay = tiktok.fileName
                                    
                                    showingPlayerView = true
                                    
                                }
                        }
                        
                    }
                }
                
            }
            
        }
        .navigationBarItems(trailing: addNewVideoButton)
        .onAppear(){
            playlistArray = downloader.TikData.filter () { plist.videoArr.contains($0.fileName) }
        }
        
        .fullScreenCover(isPresented: $showingPlayerView) {
            
            PlayerView(currentVideo: videoForPlay, playlistArray: $playlistArray, videoToPlay: $videoForPlay)
   
        }
        
    }
    
    //MARK: addPlistButton
    
    var addNewVideoButton: some View {
        
        Button(action: {
            withAnimation(.easeInOut) {
                showDownloadPopUpView = true
            }
        }){
            Image("Plus").foregroundColor(.roseColor)
        }
        .fullScreenCover(isPresented: $showDownloadPopUpView) {
            DownloadPopUpView( isWithPlayer: false, playlist: plist)
   
        }
    }
  
}
