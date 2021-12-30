//
//  PlayListVideoListView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 22.12.2021.
//

import SwiftUI
import AVKit
import AVFoundation

struct PlayListVideoListView: View {
    
    //New modalView:
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    @EnvironmentObject var downloader: Downloader
    @State private var showingPlayerView = false
    @State private var player = AVPlayer(url: URL(string: "https://www.rmp-streaming.com/media/big-buck-bunny-360p.mp4")!)
    @State var plist: Playlist
   
    
    
    
    var body: some View {
        
        VStack{
            
            
            if plist.videoArr.isEmpty {
                
                Image("Play")
                    .padding(5)
                Text("It's empty for now")
                    .montserrat16TextStyle
                    .padding(.bottom, 10)
                Text("Add video to playlist")
                    .montserrat16TextStyle
                    .foregroundColor(.white)
                
            } else if let arr = downloader.TikData.filter () { plist.videoArr.contains($0.fileName)} {
                
                ScrollView {
                    LazyVStack() {
                        ForEach( 0..<arr.count, id: \.self) { index in
                            
                            //VideoFileRow(tiktok: arr[index])
                            arr[index].vImg
                                .onTapGesture {
                                    
                                    player = AVPlayer(url: arr[index].url(forFile: .video))
                                    
                                    showingPlayerView = true
                                    
                                }
                        }
                    }
                }
                
            }
            
        }
        .navigationBarItems(trailing: addNewVideoButton)
        .onAppear(){
            print(plist.videoArr)
        }
        
        .fullScreenCover(isPresented: $showingPlayerView) {
            PlayerView(player: $player)
        
            
            
        }
        
    }
    
    //MARK: addPlistButton
    
    var addNewVideoButton: some View {
        
        Button(action: {
            withAnimation(.easeInOut) {
                self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
                    ModalPopUpView(plist: $plist).environmentObject(self.downloader)
                        .transition(.move(edge: .bottom))
                }
            }
        }){
            Image("Plus").foregroundColor(.roseColor)
        }
    }
    
    
    
    struct ModalPopUpView: View {
        
        @State private var value = 0.0
        
        // Link for download new video
        @State private var downloadLink = ""
        @State private var isLoading = false
        @EnvironmentObject var downloader: Downloader
        @Environment(\.viewController) private var viewControllerHolder: UIViewController?
        @Binding var plist: Playlist
        var body: some View {
            
            ZStack{
                VStack{
                    Color.barBackgroundGrey
                        .opacity(0.1)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                            }
                        }
                    VStack{
                        
                        Spacer()
                        
                        if isLoading{
                            
                            HStack{
                                Spacer()
                                ProgressView()
                                    .scaleEffect(1.5)
                                Spacer()
                            }
                            .padding(.bottom, 10)
                            Text("Clip is downloading")
                            Spacer()
                            
                        } else {
                            
                            HStack{
                                Text("Add clip")
                                    .navigationTitleTextStyle
                                    .padding(.horizontal, 20)
                                Spacer()
                                Button(action: {
                                    self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                                }) {
                                    Image("CloseCircleGray")
                                    
                                }      .padding(.horizontal, 20)
                                
                            }
                            
                            HStack{
                                Text("Link")
                                    .montserrat16TextStyle
                                    .padding(.leading, 20)
                                    .padding(.vertical, 10)
                                Spacer()
                                
                            }
                            
                            
                            TextField("Insert a link to the clip", text: $downloadLink)
                                .padding(10)
                                .frame(width: UIScreen.width * 0.92)
                                .background(Color.barGrey)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            
                            Button(action: {
                                UIPasteboard.general.string = downloadLink
                                withAnimation(.easeInOut) {
                                    self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
                                        DownloadPopUpView(isWithPlayer: false, playlist: plist).environmentObject(self.downloader)
                                            .transition(.move(edge: .bottom))
                                        
                                    }
                                    
                                }
                                
                                
                            }){
                                HStack{
                                    Image(systemName: "star.fill")
                                        .frame(width: 20, height: 20, alignment: .center)
                                        .foregroundColor(.white)
                                    Text("Add")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    
                                }
                            }
                            .actionButtonStyle()
                            .padding(.vertical, 20)
                            
                            Spacer()
                            
                        }
                    }
                    .background(Color.barBackgroundGrey).clipShape(RoundedRectangle(cornerRadius: 22))
                    .frame(height: UIScreen.height * 0.3)
                    .frame(maxWidth:.infinity)
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            }
        }
        
    }
    
}
