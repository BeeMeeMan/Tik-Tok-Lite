//
//  PListCreator.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 19.12.2021.
//

import SwiftUI

struct PListCreator: View {
    
    @State private var plistName: String = ""
    @State private var plistDiscription: String = ""
    
    // image picker:
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
   // ------
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        VStack(alignment: .center){
            
            
            ZStack{
                
            if image != nil{
                image?
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(color: Color.white, radius: 2)
                    .padding(.top, 60)
                    .padding(.bottom, 20)
                
            } else {
                
                Image("CirclePhoto")
                    .frame(width: 150, height: 150)
                    .shadow(color: Color.white, radius: 2)
                    .padding(.top, 60)
                    .padding(.bottom, 20)
            }
                    
            }
            .scaleEffect(showingImagePicker ? 1.1 : 1)
            
            
                .onTapGesture {
                    
                    self.showingImagePicker = true
                }
            
            Text("Playlist cover")
                .navigationTitleTextStyle
            Text("(Not necessary)")
                .font(.custom("Helvetica", size: 12).weight(.regular))

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
        .navigationTitle("Playlists")
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            ImagePicker(image: self.$inputImage)
        }
        
    }
    
    func loadImage(){
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
    }
}

struct PListCreator_Previews: PreviewProvider {
    static var previews: some View {
        PListCreator()
    }
}
