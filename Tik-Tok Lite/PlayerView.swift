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
    
    @Binding var player : AVPlayer
    @State var isplaying = false
    @State var showcontrols = false
    @State var value : Float = 0
    @State private var sliderValue = 0.0
    @Environment(\.presentationMode) var presentationMode
    @State var observer: Any?
    @EnvironmentObject var downloader: Downloader
    @State private var selectedTab = 0
    @Binding var playlistArray: [AVPlayer]
    
    var body: some View {
  
            TabView(selection: $selectedTab) {
                ForEach(0..<playlistArray.count, id: \.self) { index in
                    ZStack{
                        VideoPlayer(player:  $playlistArray[index])
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                self.showcontrols.toggle()
                            }
  
            if self.showcontrols{
                
        VStack{
            
            
            Button(action: {
                
                closeVideoPlayerView()
        
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
                Button(action: {
                    
                    if self.isplaying{
                        
                        self.player.pause()
                        self.isplaying = false
                        
                    }
                    else{
                        
                        self.player.play()
                        self.isplaying = true
                        
                    }
                    
                }) {
                    if self.isplaying{
                        
                        Image("PauseCircle")
                        
                    } else {
                        
                        Image("PlayCircle")
                        
                    }
                    
                }
                
                Spacer()
                
         
         
            
            Slider(
                value: $sliderValue,
                in: 0...1,
                onEditingChanged: { editing in
                    self.player.pause()
                    self.player.seek(to: CMTime(seconds: (self.player.currentItem?.duration.seconds)! * self.sliderValue, preferredTimescale: 1))
                    self.player.play()
                }
            )
                
                    .accentColor(.roseColor)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 20)
            
            }
        }
            
        }
        }
   
           
        
        .onAppear {
            observer = self.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 2), queue: .main) { (_) in
                self.sliderValue = Double(self.player.currentTime().seconds / (self.player.currentItem?.duration.seconds)!)
               print(self.sliderValue)
                if self.sliderValue >= 0.99{
                    self.player.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
                    self.player.play()
                    self.player.play()
                }
            }
            self.player.play()
            self.isplaying = true
            
        }
        .onDisappear(){
            self.player.removeTimeObserver(observer!)
            self.player.replaceCurrentItem(with: nil)
            presentationMode.wrappedValue.dismiss()
        }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
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


//import Foundation
//
//class MyView : UIView {
//    
//    override func hitTest(_ point: CGPoint, with e: UIEvent?) -> UIView? {
//        if let result = super.hitTest(point, with:e) {
//            return result
//        }
//        for sub in self.subviews.reversed() {
//            let pt = self.convert(point, to:sub)
//            if let result = sub.hitTest(pt, with:e) {
//                return result
//            }
//        }
//        return nil
//    }
//}
