//
//  PListCreator.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 19.12.2021.
//

import SwiftUI

struct PlaylistCreationView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataStorage: StorageModel
    
    @State private var showModalPopUpView = false
    @State private var plistName: String = ""
    @State private var plistDiscription: String = ""
    var index: Int?
    
    // image picker:
    @State private var image: UIImage?
    @State private var shouldPresentCamera = false
    @State private var showingImagePicker = false
    
    init(index: Int?) {
        self.index = index
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                ZStack {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showModalPopUpView = true
                        }
                    }){
                        if let image = image {
                            Image(uiImage: image)
                                .circleIconModifier()
                        } else {
                            Image("CirclePhoto")
                                .circleIconModifier()
                        }
                    }
                }
                
                Text("Playlist cover")
                    .navigationTitleTextStyle
                Text("(Not necessary)")
                    .montserrat12TextStyle
                
                VStack(alignment: .leading) {
                    Text("Playlist name")
                        .navigationTitleTextStyle
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.barBackgroundGrey)
                            .frame(width: Settings.Size.mainButtonsWidth,
                                   height: Settings.Size.mainButtonsHeight,
                                   alignment: .center)
                            .cornerRadius(Settings.Size.cornerRadius)
                        
                        TextField("Enter playlist name", text: $plistName)
                            .padding(5)
                            .frame(width: Settings.Size.mainButtonsWidth)
                            .cornerRadius(Settings.Size.cornerRadius)
                            .background(Color.barBackgroundGrey)
                    }
                    Text("Playlist discription")
                        .navigationTitleTextStyle
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $plistDiscription)
                            .padding(2)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(4)
                            .frame(width: Settings.Size.mainButtonsWidth,
                                   height: Settings.Size.playlistDescriptionTextEditorHeight,
                                   alignment: .center)
                            .background(Color.barBackgroundGrey)
                            .cornerRadius(Settings.Size.cornerRadius)
                        
                        if plistDiscription.isEmpty {
                            Text("Not necessary")
                                .padding()
                                .font(.custom("Helvetica", size: 16).weight(.regular))
                                .foregroundColor(Color.lightGray)
                                .allowsHitTesting(false)
                        }
                    }
                    Spacer()
                    
                    Button(action: {
                        dataStorage.savePlaylist(at: index,
                                                 plistName: plistName,
                                                 plistDiscription: plistDiscription,
                                                 image: image)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        makeMainButtonLabel(image: index == nil ? "star.fill" : "pencil",
                                            text: index == nil ? "Create" : "Save changes",
                                            isReversed: false,
                                            color: .gray)
                    }
                    .mainButtonStyle(color: .gray)
                    .padding(.bottom, 50)
                }
            }
        }
        .navigationTitle(index == nil ? "Create playlist" : "Edit playlist")
        .sheet(isPresented: $showingImagePicker) {
            ImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$showingImagePicker)
        }
        .fullScreenCover(isPresented:  $showModalPopUpView) {
            PlaylistCreationPopupView(showingImagePicker: $showingImagePicker, shouldPresentCamera: $shouldPresentCamera)
        }
        .onAppear {
            loadData(index: index)
        }
    }
    
    func loadData(index: Int?) {
        if let index = index {
            let playlist = dataStorage.playlistArray[index]
            plistName = playlist.name
            plistDiscription = playlist.description
            if let uiImage = UIImage.load(filename: playlist.name) {
                image = uiImage
            }
        }
    }
}

struct PListCreator_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistCreationView(index: nil)
            .preferredColorScheme(.dark)
    }
}
