//
//  ModalPopUpView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 29.12.2021.
//

import SwiftUI
import AVKit

struct DownloadPopUpView: View {
 
            @EnvironmentObject var downloader: Downloader
    
           // @Binding var showModalPopUpView: Bool
            @State private var downloadLink = ""
            @State private var backOpacity = 0.000001
            @State var isLoading = false
            @State var showingPlayerView = false
            
            @Environment(\.presentationMode) var presentationMode
    
            var isWithPlayer: Bool = true
            var playlist: PlaylistData?
            
  
    
            var body: some View {
              
                    ZStack{
                        Color.black
                            .opacity(backOpacity)
                            .onTapGesture {
                               
                                    backOpacity = 0.000001
                                    closeView()
                               
                            }
                            .onAppear {
                                withAnimation(.linear(duration: 0.6).delay(0.2)){
                                    backOpacity = 0.5
                                }
                                
                            }
                        VStack{
                            Spacer()
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
                                    .onAppear(){
                                        
                                        downloadVideo(isWithPlayer)
                                        
                                    }
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
                                          isLoading = true
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
                                    
                                    Spacer()
                                    
                                }
                            }
                            .background(Color.barBackgroundGrey).clipShape(RoundedRectangle(cornerRadius: 22))
                            .frame(height: UIScreen.height * 0.3)
                            .frame(maxWidth:.infinity)
                        
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea()
                    .background(BackgroundCleanerView())
              
            }
           
    
    func downloadVideo(_ isWithPlayer: Bool){
    
        guard let clip = UIPasteboard.general.string else {
         

            let errsNotif = Notification(text: "No URL Provided", title: "Error")
            errsNotif.execute()
            DispatchQueue.main.async {
                closeView()
        //    self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }
            return
            
        }
        print(clip)
        let dlr = TiktokDownloader(withUrl: clip)
        
        try! dlr.download() { result in
            switch result {
            case .success(let r):
                DispatchQueue.main.async {
 
                    self.downloader.TikDataTemp = []
                    self.downloader.TikDataTemp.append(r)
                let succesNotif = Notification(text: "Successfully downloaded", title: "Info")
                succesNotif.execute()
                   
                    if !isWithPlayer{
                            let newItem = self.downloader.TikDataTemp.last!
                            let index = downloader.plistArr.firstIndex(of: playlist!)
                            downloader.plistArr[index!].videoArr.append(newItem.fileName)
                            savePlaylistArray(downloader.plistArr)
                            self.downloader.TikData.append(newItem)
         
                    }
                    closeView()
 
                }

            case .failure(let err):
  
                DispatchQueue.main.async {
                    
                    closeView()

                }
                switch err {
                    
                case .InvalidUrlGiven:
                    let errsNotif = Notification(text: "The url you gave is incorrect", title: "Error")
                    errsNotif.execute()
                    
                case .VideoSaveFailed, .DownloadVideoForbiden, .VideoDownloadFailed:
                    let errsNotif = Notification(text: "Failed to download video", title: "Error")
                    errsNotif.execute()
                    
                    
                default:
                    let errsNotif = Notification(text: "Generic error", title: "Error")
                    errsNotif.execute()
                    
                    
                }
            }
            
        }
        UINotificationFeedbackGenerator().notificationOccurred(.success)
 
    }
              
    
    
    func closeView(){
        
        self.presentationMode.wrappedValue.dismiss()
    }
        }
    

