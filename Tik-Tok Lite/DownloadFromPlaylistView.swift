//
//  DownloadFromPlaylistView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 16.01.2022.
//

import SwiftUI

    struct DownloadFromPlaylistView: View {
        
        @State private var value = 0.0
        
        // Link for download new video
        @State private var downloadLink = ""
        @State private var isLoading = false
        @State private var showDownloadPopUpView = false
        @EnvironmentObject var downloader: Downloader
        //@Environment(\.viewController) private var viewControllerHolder: UIViewController?
        @Environment(\.presentationMode) var presentationMode
        @Binding var plist: Playlist
       
        var body: some View {
            
            ZStack{
                VStack{
                    Color.black
                        .opacity(0.3)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                
                                closeView()
                              //  self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                            }
                        }
                    VStack{
                        
                        Spacer()
                        
                        if isLoading{
                            
                            HStack{
                                Spacer()
                                ProgressView()
                                    .scaleEffect(1.5)
                                Spacer()
                            }
                            .padding(.bottom, 10)
                            Text("Clip is downloading")
                            Spacer()
                            
                        } else {
                            
                            HStack{
                                Text("Add clip")
                                    .navigationTitleTextStyle
                                    .padding(.horizontal, 20)
                                Spacer()
                                Button(action: {
                                    closeView()
                                    // self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                                }) {
                                    Image("CloseCircleGray")
                                    
                                }      .padding(.horizontal, 20)
                                
                            }
                            
                            HStack{
                                Text("Link")
                                    .montserrat16TextStyle
                                    .padding(.leading, 20)
                                    .padding(.vertical, 10)
                                Spacer()
                                
                            }
                            
                            
                            TextField("Insert a link to the clip", text: $downloadLink)
                                .padding(10)
                                .frame(width: UIScreen.width * 0.92)
                                .background(Color.barGrey)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            
                            Button(action: {
                                UIPasteboard.general.string = downloadLink
                                withAnimation(.easeInOut) {
                                    closeView()
                                    showDownloadPopUpView = true
                                   // self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
//                                        DownloadPopUpView(isWithPlayer: false, playlist: plist).environmentObject(self.downloader)
//                                            .transition(.move(edge: .bottom))
                                        
                                   //closeView() }
                                    
                                }
                                
                                
                            }){
                                HStack{
                                    Image(systemName: "star.fill")
                                        .frame(width: 20, height: 20, alignment: .center)
                                        .foregroundColor(.white)
                                    Text("Add")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                    
                                }
                            }
                            .actionButtonStyle()
                            .padding(.vertical, 20)
                            .fullScreenCover(isPresented:  $showDownloadPopUpView) {
                                DownloadPopUpView(isWithPlayer: false, playlist: plist).environmentObject(self.downloader)
                            }
                            Spacer()
                            
                        }
                    }
                    .background(Color.barBackgroundGrey).clipShape(RoundedRectangle(cornerRadius: 22))
                    .frame(height: UIScreen.height * 0.3)
                    .frame(maxWidth:.infinity)
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            }
            .background(BackgroundCleanerView())
        }
        
        func closeView(){
            self.presentationMode.wrappedValue.dismiss()
            
        }
        
    }

//struct DownloadFromPlaylistView_Previews: PreviewProvider {
//    static var previews: some View {
//        DownloadFromPlaylistView()
//    }
//}
