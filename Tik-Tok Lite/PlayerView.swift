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
    
  //  @Binding var player : AVPlayer
    

    @State var isplaying = false
    @State var showcontrols = false
    @State var value : Float = 0
    @State private var sliderValue = 0.0
    @Environment(\.presentationMode) var presentationMode
    @State var observer: Any?
    @EnvironmentObject var downloader: Downloader
    @State var currentVideo: String
    @Binding var playlistArray: [Tiktok]
    @Binding var videoToPlay: String
//    @State var reels = mediaFileJSON.map{ item -> Reel in
//        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
//        let player = AVPlayer(url: URL(fileURLWithPath: url))
//        return Reel(player: player, mediaFile: item)
//    }
   
    var body: some View {
        
        GeometryReader{ proxy in
            
            let size = proxy.size
  
            TabView(selection: $currentVideo) {
                ForEach($playlistArray) { $tiktok in
                    TiktokPlayerView(tiktok: $tiktok, currentVideo: $currentVideo)
                            .frame(width: size.width)
                            .padding()
                            .rotationEffect(.degrees(-90))
                            .ignoresSafeArea(.all, edges: .top)
                            .tag(tiktok.fileName)
                            .onAppear(){
                                tiktok.player = AVPlayer(url: tiktok.url(forFile: .video))
                            }
                            .onDisappear {
                                tiktok.player = nil
                            }
                           
//            if self.showcontrols{
//                
//        VStack{
//            
//            
//            Button(action: {
//                
//                closeVideoPlayerView()
//        
//            })  {
//
//                HStack{
//                    Image("CloseSquare")
//                        .padding(.vertical, 10)
//                    Text("Close")
//                        .padding(.vertical, 10)
//                        .foregroundColor(.roseColor)
//                }
//                .scaleEffect(1.3)
//                    
//            }
//            
//            .position(x: 70, y: 50)
//            
//            
//            VStack{
//               
//              
//                Spacer()
//                Button(action: {
//                    
//                    if self.isplaying{
//                        
//                        self.player.pause()
//                        self.isplaying = false
//                        
//                    }
//                    else{
//                        
//                        self.player.play()
//                        self.isplaying = true
//                        
//                    }
//                    
//                }) {
//                    if self.isplaying{
//                        
//                        Image("PauseCircle")
//                        
//                    } else {
//                        
//                        Image("PlayCircle")
//                        
//                    }
//                    
//                }
//                
//                Spacer()
//                
//         
//         
//            
//            Slider(
//                value: $sliderValue,
//                in: 0...1,
//                onEditingChanged: { editing in
//                    self.player.pause()
//                    self.player.seek(to: CMTime(seconds: (self.player.currentItem?.duration.seconds)! * self.sliderValue, preferredTimescale: 1))
//                    self.player.play()
//                }
//            )
//
//                    .accentColor(.roseColor)
//                    .padding(.bottom, 30)
//                    .padding(.horizontal, 20)
//            
//            }
//        }
//            
//        }
        
                    //  .tag(reel.id)
        
  //      .onAppear {
            
           
//            observer = self.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 2), queue: .main) { (_) in
//                self.sliderValue = Double(self.player.currentTime().seconds / (self.player.currentItem?.duration.seconds)!)
//               print(self.sliderValue)
//                if self.sliderValue >= 0.99{
//                    self.player.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
//                    self.player.play()
//                    self.player.play()
//                }
//            }
//            self.player.play()
//            self.isplaying = true
            
//        }
//        .onDisappear(){
//            self.player.removeTimeObserver(observer!)
//            self.player.replaceCurrentItem(with: nil)
//            presentationMode.wrappedValue.dismiss()
//        }
                }
            }
            .rotationEffect(.degrees(90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
            
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(.black)
        .onAppear {
            currentVideo = videoToPlay
        }
        
    }
    
    func closeVideoPlayerView(){
        presentationMode.wrappedValue.dismiss()
        
    }
   
}

struct VideoPlayer : UIViewControllerRepresentable {

    @Binding var player : AVPlayer

    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPlayer>) -> AVPlayerViewController {

        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<VideoPlayer>) {


    }
}

struct TiktokPlayerView: View {

    @Binding var tiktok : Tiktok
    @Binding var currentVideo: String
    @State var showcontrols = false
    @State var isplaying = true
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {

        ZStack{
            if let  player = tiktok.player{
            CustomVideoPlayer(player: player)
                    .onTapGesture {
                        showcontrols.toggle()
                    }
                
                if self.showcontrols{
               
                       
               
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
                           
                       
                }
               
               
                    
                    
                GeometryReader{ proxy -> Color in

                    let minY = proxy.frame(in: .global).minY
                    let size = proxy.size

                    DispatchQueue.main.async {
                        if -minY < (size.height/2) && minY < (size.height/2) && currentVideo == tiktok.fileName && isplaying {
                            player.play()
                            
                        } else {
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

