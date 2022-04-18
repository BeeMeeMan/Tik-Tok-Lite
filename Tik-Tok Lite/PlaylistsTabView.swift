//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI

struct PlaylistsTabView : View {
    @Environment(\.presentationMode) var PlayListPresentationMode
    @EnvironmentObject var dataStorage: StorageModel
    
    @State private var selection: Int? = nil
    @State private var index: Int? = nil
    @State private var showEditView = false
    @State private var image: UIImage?
    @State private var listCovers: [UIImage?] = []
    
    @Binding var showDownloadFromPlaylistPopUpView: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: PlaylistCreationView(index: index),
                               isActive: $showEditView) { EmptyView() }
                Color.black
                EmptyPlaylistsTabView(index: $index)
                    .opacity(dataStorage.playlistArray.isEmpty ? 1 : 0)
                
                FilledPlaylistsTabView(selection: $selection,
                                       index: $index,
                                       showEditView: $showEditView)
                    .opacity(dataStorage.playlistArray.isEmpty ? 0 : 1)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: addPlistButton)
            .navigationTitle("Playlists")
            .mainTextStyle
        }
    }
    
    //MARK: AddPlistButton
    var addPlistButton: some View {
        Button {
            index = nil
            self.showEditView = true
        } label: { Image("Plus").foregroundColor(.roseColor) }
    }
}

struct PlaylistsTabView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsTabView(showDownloadFromPlaylistPopUpView: .constant(false))
            .environmentObject(StorageModel())
            .preferredColorScheme(.dark)
    }
}
