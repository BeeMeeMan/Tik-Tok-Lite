//
//  ContentView.swift
//  Custom Video Player
//
//  Created by Kavsoft on 14/01/20.
//  Copyright © 2020 Kavsoft. All rights reserved.(Stolen)
//

import SwiftUI
import AVKit

struct ReelsPlayerView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var currentVideo: String
    @State private var showcontrols = false
    
    @Binding var playlistArray: [Tiktok]
    @Binding var videoToPlay: String
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let size = proxy.size
                
                TabView(selection: $currentVideo) {
                    ForEach($playlistArray) { $tiktok in
                        TiktokPlayerView(showcontrols: $showcontrols, tiktok: $tiktok, currentVideo: $currentVideo, isReel: true)
                            .frame(width: size.width)
                            .padding(.top, 2)
                            .rotationEffect(.degrees(-90))
                            .ignoresSafeArea(.all, edges: .top)
                            .tag(tiktok.fileName)
                    }
                }
                .rotationEffect(.init(degrees: 90))
                .frame(width: size.height)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(width: size.width)
            }
            .ignoresSafeArea(.all, edges: .top)
            .background(.black)
            
            if showcontrols {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) { HStack {
                    Image("CloseSquare")
                    Text("Close")
                        .foregroundColor(.roseColor)
                }
                .padding(10)
                .scaleEffect(1.3)
                }
                .position(x: 70, y: 50)
            }
        }
        .onAppear {
            currentVideo = videoToPlay
        }
    }
}
