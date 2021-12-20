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
    
    
    @State var player = AVPlayer(url: URL(string: "")!)
    @State var isplaying = false
    @State var showcontrols = false
    @State var value : Float = 0
    @State private var presentAlert = false
    @State private var sliderValue = 0.0
    @Environment(\.presentationMode) var presentationMode
    @State var observer: Any?
    var body: some View {
        
        VStack{
            HStack{
                Text("Download video")
                    .bold()
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.top, 10)
            
            ZStack{
                
                VideoPlayer(player: $player)
                
                VStack{
                    
                    if self.showcontrols{
                        
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
            .frame(width: UIScreen.main.bounds.width * 0.93, height: UIScreen.main.bounds.width * 1.50)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(radius: 7)
            .onTapGesture {
                
                self.showcontrols.toggle()
            }
            
            Button(action: {
                presentAlert = true
                
                
            })  {
                HStack{
                    Image(systemName: "arrow.down.doc.fill")
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(.white)
                    Text("Download clip")
                        .font(.system(size: 16, weight: .regular, design: .default))
                    
                }
            }
            .roseButtonStyle()
            .padding(.top, 10)
            .padding(.bottom, 10)
            Button(action: {
                
                
                
            })  {
                HStack{
                    Image(systemName: "star.fill")
                        .frame(width: 20, height: 20, alignment: .center)
                        .foregroundColor(.white)
                    Text("Add to playlist")
                        .font(.system(size: 16, weight: .regular, design: .default))
                    
                }
            }
            .roseButtonStyle()
            Spacer()
        }
        .alert("Attention", isPresented: $presentAlert, actions: {
            
            Button("Ok") {
                
                presentationMode.wrappedValue.dismiss()
                
            }
        }, message: {
            
            Text("Video saved in your gallery")
            
            
        }) // 4
        
        
        .background(Color.clear.edgesIgnoringSafeArea(.all))
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
            
            //  self.showcontrols = true
            self.player.play()
            self.isplaying = true
            
        }
        .onDisappear(){
            //player.pause()
            self.player.removeTimeObserver(observer!)
            self.player.replaceCurrentItem(with: nil)
            presentationMode.wrappedValue.dismiss()
        }
    }
}



struct VideoPlayer : UIViewControllerRepresentable {
    
    @Binding var player : AVPlayer
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPlayer>) -> AVPlayerViewController {
        
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resize
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<VideoPlayer>) {
        
        
    }
}



