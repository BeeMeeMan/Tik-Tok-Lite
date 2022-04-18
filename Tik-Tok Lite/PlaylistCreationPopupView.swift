//
//  PlaylistCreationPopupView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 07.04.2022.
//

import SwiftUI

struct PlaylistCreationPopupView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var backOpacity = 0.000001
    
    @Binding var showingImagePicker: Bool
    @Binding var shouldPresentCamera: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(backOpacity)
                .onTapGesture {
                    backOpacity = .zero
                    closeView()
                }
                .onAppear {
                    withAnimation(.linear(duration: 0.6).delay(0.3)) {
                        backOpacity = 0.5
                    }
                }
            popupWindow
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .background(BackgroundCleanerView())
    }
    
    var popupWindow: some View {
        VStack {
            Spacer()
            VStack(alignment:.leading) {
                HStack{
                    Text("Playlist cover")
                        .navigationTitleTextStyle
                        .padding(20)
                    Spacer()
                    Button(action: { closeView() }) {
                        Image("CloseCircleGray")
                    }
                    .padding(20)
                }
                
                Button(action: {
                    showingImagePicker = true
                    shouldPresentCamera = true
                    closeView()
                }) {
                    Text("\(Image("PhotoIconGray"))   Make photo")
                        .helvetica18TextStyle(color: .white)
                }
                .padding()
                
                Button(action: {
                    showingImagePicker = true
                    shouldPresentCamera = false
                    closeView()
                }) {
                    Text("\(Image("GalleryIconGray"))   Open gallery")
                        .helvetica18TextStyle(color: .white)
                }
                .padding()
                
                Button(action: { closeView() }) {
                    Text("\(Image("CloseCircleRed"))   Cancel")
                        .helvetica18TextStyle(color: .red)
                }
                .padding()
                
                Spacer()
            }
            .background(Color.barBackgroundGrey).clipShape(RoundedRectangle(cornerRadius: 22))
            .frame(height: Settings.Size.popupViewHeight)
            .frame(maxWidth:.infinity)
        }
    }
    
    func closeView() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct PlaylistCreationPopupView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistCreationPopupView(showingImagePicker: .constant(true), shouldPresentCamera: .constant(false))
    }
}
