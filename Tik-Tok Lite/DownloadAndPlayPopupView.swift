//
//  ModalPopUpView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 29.12.2021.
//

import SwiftUI
import AVKit

struct DownloadAndPlayPopupView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var storageModel: StorageModel
    
    @State private var isSaved = false
    @State private var presentAlert = false
    @State private var showcontrols = false
    @State private var playlistToSaveIndex: Int?
    @State private var showPlaylistPicker = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Download video")
                    .bold()
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.top, 10)
            
            if let tiktok = storageModel.tiktokTemp {
                TiktokPlayerView(showcontrols: $showcontrols, tiktok: .constant(tiktok))
                    .frame(width: Constant.Size.videoPlayerWidth, height: Constant.Size.videoPlayerHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .shadow(radius: 7)
            }
            
            Button {
                let baseIndex = 0
                saveVideo(to: baseIndex)
            } label: {
                makeMainButtonLabel(image: "arrow.down.doc.fill", text: "Download clip", isReversed: false, color: .rose)
            }
            .mainButtonStyle(color: .rose)
            .padding([.top, .bottom], 10)
            
            Button {
                showPlaylistPicker = true
            } label: {
                makeMainButtonLabel(image: "star.fill", text: "Add to playlist", isReversed: false, color: .rose)
            }
            .mainButtonStyle(color: .rose)
            
            Spacer()
        }
        .fullScreenCover(isPresented: $showPlaylistPicker, content: {
            PlaylistPickerView(playlistIndex: $playlistToSaveIndex)
                .onDisappear {
                    if let playlistToSaveIndex = playlistToSaveIndex {
                        print("###Index: \(playlistToSaveIndex)")
                        saveVideo(to: playlistToSaveIndex)
                    }
                }
        })
        .alert("Attention",
               isPresented: $presentAlert,
               actions: { Button("Ok") { closeView() }},
               message: { Text("Video saved in your gallery") })
        .background(Color.clear.edgesIgnoringSafeArea(.all))
        .onDisappear() {
            if !isSaved,
               let tiktokTemp = storageModel.tiktokTemp {
                if !storageModel.playlistArray[0].videoArr.contains(tiktokTemp.name) {
                    tiktokTemp.delete()
                }
            }
        }
    }
    
    func saveVideo(to playlistIndex: Int) {
       if let tiktok = storageModel.tiktokTemp {
            storageModel.add(video: tiktok, to: playlistIndex)
            isSaved = true
            presentAlert = true
        }
    }
    
    func closeView() {
        storageModel.tiktokTemp = nil
        presentationMode.wrappedValue.dismiss()
    }
}
