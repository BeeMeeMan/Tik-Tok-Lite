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
    
    @Binding var player: AVPlayer 
    @State var isplaying = false
    @State var showcontrols = false
    @State var value : Float = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack{
            
            ZStack{
                
                VideoPlayer(player: $player)
                
                if self.showcontrols{
                    
                    Controls(player: self.$player, isplaying: self.$isplaying, pannel: self.$showcontrols,value: self.$value)
                }
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.93, height: UIScreen.main.bounds.width * 1.50)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(radius: 7)
            .onTapGesture {
                
                self.showcontrols = true
            }
            
            
        }
        .background(Color.clear.edgesIgnoringSafeArea(.all))
        .onAppear {
            self.showcontrols = true
            self.player.play()
            self.isplaying = true
           
        }
        .onDisappear(){
            //player.pause()
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct Controls : View {
    
    @Binding var player : AVPlayer
    @Binding var isplaying : Bool
    @Binding var pannel : Bool
    @Binding var value : Float
    @State var observer: Any?
    
    
    var body : some View{
        
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
                    Image("PlayCircle")
                        .opacity(0.5)
                    } else {
                        Image("PlayCircle")
                            .opacity(1.0)
                    }
                    
                       
                }
                
                Spacer()
              
            
            CustomProgressBar(value: self.$value, player: self.$player, isplaying: self.$isplaying)
            
        }.padding()
        .background(Color.black.opacity(0.4))
        .onTapGesture {
                
            self.pannel = false
        }
        .onAppear {
            
            observer = self.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { (_) in
                self.value = self.getSliderValue()
                print(self.value)
                if self.value >= 0.99{
                    self.player.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
                    self.player.play()
//                    self.player.play()
//                    self.player.removeTimeObserver(observer)
                }
            }
        }
        
        .onDisappear(){
         //   self.player.removeTimeObserver(observer)
            
        }
        
    }
    
    func getSliderValue()->Float{
        
        return Float(self.player.currentTime().seconds / (self.player.currentItem?.duration.seconds)!)
    }
    
    func getSeconds()->Double{
        
        return Double(Double(self.value) * (self.player.currentItem?.duration.seconds)!)
    }
}

struct CustomProgressBar : UIViewRepresentable {
    
    
    func makeCoordinator() -> CustomProgressBar.Coordinator {
        
        return CustomProgressBar.Coordinator(parent1: self)
    }
    
    
    @Binding var value : Float
    @Binding var player : AVPlayer
    @Binding var isplaying : Bool
    
    func makeUIView(context: UIViewRepresentableContext<CustomProgressBar>) -> UISlider {
     
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .gray
        slider.thumbTintColor = .red
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.value = value
        slider.addTarget(context.coordinator, action: #selector(context.coordinator.changed(slider:)), for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: UIViewRepresentableContext<CustomProgressBar>) {
        
        uiView.value = value
    }
    
    class Coordinator : NSObject{
        
        var parent : CustomProgressBar
        
        init(parent1 : CustomProgressBar) {
            
            parent = parent1
        }
        
        @objc func changed(slider : UISlider){
            
            if slider.isTracking{
                
                parent.player.pause()
                
                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))
                
                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))
            }
            else{
                
                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))
                  
                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))
                
                if parent.isplaying{
                    
                    parent.player.play()
                }
            }
        }
    }
}

class Host : UIHostingController<ContentView>{
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
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


