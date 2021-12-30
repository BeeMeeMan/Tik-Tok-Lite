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
            @State private var value = 0.0
    
            @State var showingPlayerView = false
  
            
            @Environment(\.viewController) private var viewControllerHolder: UIViewController?
            
    
            var isWithPlayer: Bool = true
            var playlist: Playlist?
    
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
                                VStack {
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        ProgressView()
                                            .scaleEffect(1.5)
                            
                                        Spacer()
                                    }
                                    .padding(.bottom, 10)
                                    Text("Clip is downloading")
                                    Spacer()
                                    
                                }
                        
                          
                            .background(Color.barBackgroundGrey).clipShape(RoundedRectangle(cornerRadius: 22))
                            .frame(height: UIScreen.height * 0.3)
                            .frame(maxWidth:.infinity)
                        
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea()
                    
                    .onAppear(){
                        
                        downloadVideo(isWithPlayer)
                        
                    }
                  
                    
              
            }
    
    func downloadVideo(_ isWithPlayer: Bool){
    
        guard let clip = UIPasteboard.general.string else {
         

            let errsNotif = Notification(text: "No URL Provided", title: "Error")
            errsNotif.execute()
            DispatchQueue.main.async {
            self.viewControllerHolder?.dismiss(animated: true, completion: nil)
            }
            return
            
        }
        print(clip)
        let dlr = TiktokDownloader(withUrl: clip)
        
        try! dlr.download() { result in
            switch result {
            case .success(let r):
                DispatchQueue.main.async {
   //                 if showModalPopUpView{
                    self.downloader.TikDataTemp = []
                    self.downloader.TikDataTemp.append(r)
//                    halfSheet.TikData.last?.vImg!.openSheet()
                let succesNotif = Notification(text: "Successfully downloaded", title: "Info")
                succesNotif.execute()
                   
                    if isWithPlayer{
                        
                    downloader.isDownloadedSucsess = true
                        
                    } else {
                        
                            let newItem = self.downloader.TikDataTemp.last!
                            let index = downloader.plistArr.firstIndex(of: playlist!)
                            downloader.plistArr[index!].videoArr.append(newItem.fileName)
                            savePlaylistArray(downloader.plistArr)
                            self.downloader.TikData.append(newItem)
         
                    }
                    
                    self.viewControllerHolder?.dismiss(animated: true, completion: nil)
     //               } else {
      //                  self.viewControllerHolder?.dismiss(animated: true, completion: nil)
      //              }
                }
                   // showModalView.isActivePlayer = true
          
            case .failure(let err):
             //   showModalView.isActive = false
                DispatchQueue.main.async {
                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
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
                
        }
    

