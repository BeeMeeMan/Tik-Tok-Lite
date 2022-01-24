//
//  ContentView.swift
//  Custom Video Player
//
//  Created by Kavsoft on 14/01/20.
//  Copyright © 2020 Kavsoft. All rights reserved.(Stolen)
//

import SwiftUI
import AVKit

struct PlayerView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var downloader: Downloader
    
    @State var currentVideo: String
    @Binding var playlistArray: [Tiktok]
    @Binding var videoToPlay: String
    
    var body: some View {
        
        GeometryReader{ proxy in
            
            let size = proxy.size
            
            TabView(selection: $currentVideo) {
                ForEach($playlistArray) { $tiktok in
                    TiktokPlayerView(tiktok: $tiktok, currentVideo: $currentVideo)
                    //                        .frame(width: size.width)
                        .padding(.top, 2)
                        .rotationEffect(.degrees(-90))
                        .frame(width: size.width, height: size.height)
                    //   .ignoresSafeArea(.all, edges: .top)
                        .tag(tiktok.fileName)
                        .onAppear(){
                            
                            tiktok.player = AVPlayer(url: tiktok.url(forFile: .video))
                        }
                        .onDisappear {
                            tiktok.player = nil
                        }
                    
                }
            }
            .frame(width: size.height, height: size.width)
            .rotationEffect(.degrees(90), anchor: .topLeading)
            .offset(x: proxy.size.width)
            // .rotationEffect(.degrees(90))
            //            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            //            .frame(width: size.width)
            
        }
        .edgesIgnoringSafeArea(.all)
        //.ignoresSafeArea(.all, edges: .top)
        .background(.black)
        .onAppear {
            currentVideo = videoToPlay
        }
        
    }
    
    func closeVideoPlayerView(){
        presentationMode.wrappedValue.dismiss()
        
    }
    
}



struct TiktokPlayerView: View {
    
    @Binding var tiktok : Tiktok
    @Binding var currentVideo: String
    @State var showcontrols = false
    @State var isplaying = true
    @Environment(\.presentationMode) var presentationMode
    
    @State var observer: Any?
    @State private var sliderValue = 0.0
    // @State var isSliderUpdating = false
    
    var body: some View {
        
        ZStack{
            if let  player = tiktok.player{
                
                CustomVideoPlayer(player: player)
                    .onTapGesture {
                        
                        showcontrols.toggle()
                        
                    }
                
                    .onAppear {
                        
                        showcontrols = false
                        observer = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { (_) in
                            sliderValue = Double(player.currentTime().seconds / (player.currentItem?.duration.seconds)!)
                            print(sliderValue)
                            if sliderValue >= 0.99{
                                player.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
                                player.play()
                                player.play()
                            }
                        }
                        
                        player.play()
                        isplaying = true
                        
                    }
                    .onDisappear(){
                        
                        player.removeTimeObserver(observer!)
                        player.replaceCurrentItem(with: nil)
                        
                    }
                
                if showcontrols{
                    
                    
                    
                    Button(action: {
                        
                        closeView()
                        
                    })  {
                        
                        HStack{
                            Image("CloseSquare")
                                .padding(.vertical, 10)
                            Text("Close")
                                .padding(.vertical, 10)
                                .foregroundColor(.roseColor)
                        }
                        .scaleEffect(1.3)
                        
                    }
                    
                    .position(x: 70, y: 50)
                    
                    
                    VStack{
                        Spacer()
                        
                        //  Spacer()
                        Button(action: {
                            
                            if self.isplaying{
                                
                                player.pause()
                                self.isplaying = false
                                
                            }
                            
                            else{
                                
                                player.play()
                                self.isplaying = true
                                
                            }
                            
                        }) {
                            
                            if self.isplaying{
                                
                                Image("PauseCircle")
                                    .opacity(0.7)
                                
                            } else {
                                
                                Image("PlayCircle")
                                
                            }
                            
                        }
                        
                        
                        Spacer()
                    }
                    
                    VStack{
                        Spacer()
                        Slider(
                            value: $sliderValue,
                            in: 0...1,
                            onEditingChanged: { editing in
                                player.pause()
                                self.isplaying = false
                                player.seek(to: CMTime(seconds: (player.currentItem?.duration.seconds)! * sliderValue, preferredTimescale: 100), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
                                if !editing {player.play()
                                    self.isplaying = true
                                }
                            }
                            
                        )
                        
                            .accentColor(.roseColor)
                            .padding(.bottom, 30)
                            .padding(.horizontal, 20)
                        
                    }
                    
                    
                }
                
                
                
                
                GeometryReader{ proxy -> Color in
                    
                    let minY = proxy.frame(in: .global).minY
                    let size = proxy.size
                    
                    DispatchQueue.main.async {
                        if -minY < (size.height/2) && minY < (size.height/2) && currentVideo == tiktok.fileName{
                            
                            if isplaying{
                                player.play()
                            }
                            
                        } else {
                            isplaying = true
                            player.pause()
                            
                        }
                    }
                    return Color.clear
                    
                }
                
                
            }
        }
    }
    
    
    func closeView(){
        presentationMode.wrappedValue.dismiss()
        
    }
    
}

