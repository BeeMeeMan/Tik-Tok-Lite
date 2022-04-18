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
    @EnvironmentObject var downloader: Downloader
    @State private var showingPlayerView = false
    
    @State var plist: PlaylistData
    @State var showDownloadPopUpView = false
    @State var videolistArray: [Tiktok] = []
    @State var videoForPlay = ""
   
    var body: some View {
        VStack {
            if videolistArray.isEmpty {
                Image("Play")
                    .padding(5)
                Text("It's empty for now")
                    .montserrat16TextStyle
                    .padding(.bottom, 10)
                Text("Add video to playlist")
                    .montserrat16TextStyle
                    .foregroundColor(.white)
                
            } else {
                List() {
                    ForEach(videolistArray.indices, id: \.self) { index in
                            Button {
                                videoForPlay = videolistArray[index].fileName
                                showingPlayerView = true
                            } label: {
                                videolistArray[index].vImg
                            }
                            .foregroundColor(.white)
                            .buttonStyle(PlainButtonStyle())
                            .contextMenu(menuItems: {
                                Button(role: .destructive) {
                                    withAnimation { delete(index: index) }
                                } label: { Label("Delete", systemImage: "trash") }
                            })
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive, action: {
                                    delete(index: index)
                                }) {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            .tint(.roseColor)
                        }
                        .listRowBackground(Color.black)
                        .listRowInsets(EdgeInsets())
                    }
                .listStyle(.plain)
            }
        }
        .navigationBarItems(trailing: addNewVideoButton)
        .navigationTitle(plist.name)
        .mainTextStyle
        .onAppear() {
            videolistArray = downloader.TikData.filter () { plist.videoArr.contains($0.fileName) }
        }
        .fullScreenCover(isPresented: $showingPlayerView) {
            PlayerView(currentVideo: videoForPlay, playlistArray: $videolistArray, videoToPlay: $videoForPlay)
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
            DownloadPopUpView(isWithPlayer: false, playlist: plist)
        }
    }
    
    func delete(index: Int) {
        videolistArray.remove(at: index)
    }
}
