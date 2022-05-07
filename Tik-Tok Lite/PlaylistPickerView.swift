//
//  PlaylistPicker.swift
//  Tik-Tok Lite
//
//  Created by Korsun Yevhenii on 06.05.2022.
//

import SwiftUI

struct PlaylistPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var storageModel: StorageModel
    @State private var isNewPlaylist: Bool = true
    @State private var isCreatePlaylist: Bool = false
    @State private var playlistInnerIndex: Int = 1
    @Binding var playlistIndex: Int?
    
    var body: some View {
        VStack {
            if isNewPlaylist {
                addToPlaylistView
            } else {
                playlistSelectorView
            }
            
        }
        .modifier( PopupOverlayViewModifier() {
            playlistIndex = nil
            closeView()
        } )
    }
    
    var addToPlaylistView: some View {
        Group {
            HStack {
                Text("Add to playlist")
                Spacer()
                Button {
                    playlistIndex = nil
                    closeView()
                } label: {
                    Image("CloseCircleGray")
                }
            }
            .padding([.top, .horizontal])
            
            Button(action: { isNewPlaylist = false }){
                HStack {
                    Image(systemName: "star.square.fill").foregroundColor(.roseColor).padding()
                        .font(.system(size: 25))
                    Spacer()
                    Text("Choose existing")
                    Spacer()
                    Image(systemName: "chevron.right.circle.fill").foregroundColor(.roseColor).padding()
                        .font(.system(size: 25))
                }
            }
            .grayPickerButtonStyle()
            .padding()
            
            Button(action: { isCreatePlaylist = true }){
                makeMainButtonLabel(image: "star.fill", text: "Create new", isReversed: false, color: .rose)
            }
            .mainButtonStyle(color: .rose)
            .padding(.bottom, 50)
            .fullScreenCover(isPresented: $isCreatePlaylist) {
                PlaylistCreationView(index: nil, isInNavigationStack: false)
            }
        }
    }
    
    var playlistSelectorView: some View {
        Group {
            HStack {
                Text("Choose a playlist")
                Spacer()
                Button {
                    playlistIndex = playlistInnerIndex
                    closeView()
                } label: {
                    Text("Done").foregroundColor(.roseColor)
                }
            }
            .padding([.top, .horizontal])
            
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: UIScreen.width - 18, height: 32)
                    .foregroundColor(.roseColor)
                
                Picker("", selection: $playlistInnerIndex) {
                    ForEach(1..<storageModel.playlistArray.count, id: \.self) {
                        Text(storageModel.playlistArray[$0].name)
                    }
                }
                .pickerStyle(.wheel)
            }
        }
    }
    
    func closeView() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct PlaylistPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistPickerView(playlistIndex: .constant(1))
    }
}
