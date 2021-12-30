//
//  PListCreator.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 19.12.2021.
//

import SwiftUI

struct PListCreatorView: View {
  
    
    //New modalView:
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    @State private var plistName: String = ""
    @State private var plistDiscription: String = ""
    
    // image picker:
    @State private var image: Image? = Image("CirclePhoto")
    @State private var shouldPresentCamera = false
    @State private var showingImagePicker = false
    
    @EnvironmentObject var downloader: Downloader
    @Environment(\.presentationMode) var presentationMode

    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack{
        
        VStack(alignment: .center){
            
            
            ZStack{
                Button(action: {
                    withAnimation(.easeInOut) {
                    self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
                        ModalPopUpView(showingImagePicker: $showingImagePicker, shouldPresentCamera: $shouldPresentCamera)
                            .transition(.move(edge: .bottom))
                    }
                    }
                }){
                    image!
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .shadow(color: Color.white, radius: 2)
                            .padding(.top, 60)
                            .padding(.bottom, 20)
                            
                    }
                 
                    
                }
            
             
            
            Text("Playlist cover")
                .navigationTitleTextStyle
            Text("(Not necessary)")
                .montserrat12TextStyle

            VStack(alignment: .leading){
               
                    Text("Playlist name")
                        .navigationTitleTextStyle
               
                
                ZStack{
                    Rectangle()
                        .foregroundColor(Color.barBackgroundGrey)
                        .frame(width: UIScreen.width * 0.92, height: 53, alignment: .center)
                        .cornerRadius(10)
                    
                    
                    
                    TextField("Enter playlist name", text: $plistName)
                        .padding(5)
                        .frame(width: UIScreen.width * 0.92)
                        .cornerRadius(10)
                        .background(Color.barBackgroundGrey)
                   
                    
                }
                
                
                    Text("Playlist discription")
                        .navigationTitleTextStyle
                
                ZStack(alignment: .topLeading) {
               
                TextEditor(text: $plistDiscription)
                    .padding(2)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                    .frame(width: UIScreen.width * 0.92, height: 200, alignment: .center)
                    .background(Color.barBackgroundGrey)
                    .cornerRadius(10)
                
                if plistDiscription == "" {
                    Text("Not necessary")
                        .padding(6)
                        .font(.custom("Helvetica", size: 16).weight(.regular))
                        .foregroundColor(Color.lightGray)
                }
                
            }
                Spacer()
                
                Button(action: {
                    // Save lpist in arr of plist in UserDefault:
                    if plistName != "" {
                        
                        downloader.plistArr.append(Playlist(name: plistName, description: plistDiscription ))
                        savePlaylistArray(downloader.plistArr)
                        self.presentationMode.wrappedValue.dismiss()
                        
                       
                    }
                   // print("\(downloader.TikData.last!.fileName)")
                    print("Create plist name \(plistName), discription: \(plistDiscription) ")
                    
                }){
                    HStack{
                        Image(systemName: "star.fill")
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(.white)
                        Text("Create")
                            .font(.system(size: 16, weight: .regular, design: .default))
                        
                    }
                }
                .grayButtonStyle()
                .padding(.bottom, 50)
                
      
            }
            
        }
            
        
            
        }
        .navigationTitle("Playlists")
        
        .sheet(isPresented: $showingImagePicker) {
            SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$showingImagePicker)
    }
        

    }
    
//    func loadImage(){
//        guard let inputImage = inputImage else {return}
//        image = Image(uiImage: inputImage)
//    }
//
    
    struct ModalPopUpView: View {
        
        @Binding var showingImagePicker: Bool
        @Binding var shouldPresentCamera: Bool
        @State private var value = 0.0
        @Environment(\.viewController) private var viewControllerHolder: UIViewController?
        
        var body: some View {
          
                ZStack{
                    Color.barBackgroundGrey
                        .opacity(0.1)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                            self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                            }
                        }
                    VStack{
                        Spacer()
                        
                        VStack(alignment:.leading) {
                            HStack{
                            Text("Playlist cover")
                                    .navigationTitleTextStyle
                                    .padding(20)
                                Spacer()
                                Button(action: {
                                    self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                                }) {
                                    Image("CloseCircleGray")
                                       
                                }.padding(20)
                               
                            }
            
                                  
                            Button(action: {
                                showingImagePicker = true
                                shouldPresentCamera = true
                                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                            }) {
                                Text("\(Image("PhotoIconGray"))   Make photo")
                                    .font(.custom("Helvetica", size: 18).weight(.regular))
                                    .foregroundColor(.white)
                            }
                          //  .whiteToRoseButtonStyle()
                            .padding(10)
                            
                            Button(action: {
                                showingImagePicker = true
                                shouldPresentCamera = false
                               
                                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                            }) {
                                Text("\(Image("GalleryIconGray"))   Open gallery")
                                    .font(.custom("Helvetica", size: 18).weight(.regular))
                                    .foregroundColor(.white)
                            }
                            //.whiteToRoseButtonStyle()
                            .padding(10)
                            
                            Button(action: {
                                
                                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                            }) {
                                Text("\(Image("CloseCircleRed"))   Cancel")
                                    .font(.custom("Helvetica", size: 18).weight(.regular))
                            }
                            .foregroundColor(.red)
                            .padding(10)
                            
                            Spacer()
                            
                        }
                        .background(Color.barBackgroundGrey).clipShape(RoundedRectangle(cornerRadius: 22))
                        .frame(height: UIScreen.height * 0.3)
                        .frame(maxWidth:.infinity)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
          
        }
            
    }
}

struct PListCreator_Previews: PreviewProvider {
    static var previews: some View {
        PListCreatorView()
    }
}
