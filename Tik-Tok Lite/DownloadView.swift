//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//


import SwiftUI
import AVKit
import AVFoundation

var size: CGFloat = 160
let baseDocUrl = try! FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)


struct DownloadView: View {
    
    @EnvironmentObject var showModalView: ShowModalView
    @State private var showingPromoView = false
    @State var showingInfoView = false
    @State var update = false
    @StateObject var notifDelegate = NotificationDelegate()
//    @EnvironmentObject var halfSheet: HalfSheetPosition
//    @EnvironmentObject var TikData: HalfSheetPosition
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
                
                Color.black
                
                VStack{
                    
                    HStack{
                        
                        Text("Instruction")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Spacer()
                        
                        showingPromoViewButton
                    }
                    .padding(16)
                    
                    Spacer()
                    Spacer()
                    Spacer()
    
                    Image("Download")
                        .scaleEffect(1.6, anchor: .center)
                    
                    Text("Download clip")
                        .mainTextStyle
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    downloadClipButton
                    
                }
                
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: showingInfoViewButton)
                .navigationTitle("Download clip")
                .font(.system(size: 16, weight: .regular, design: .default))
                
            }
            
            //.fullScreenCover(isPresented: $showingPromoView, content: TestPopUp.init)
            .popover(isPresented: $showingPromoView) {
                TestPopUp()
                   }
            .fullScreenCover(isPresented: $showingInfoView, content: IntroTabView.init)
            
        }
    }
    
    
    //MARK: showingInfoViewButton
    
    var showingInfoViewButton: some View {
        
        Button(action:{
            
            showingInfoView = true
            
        }){
            
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundColor(.roseColor)
            
        }
    }
    
    
    //MARK: showingPromoViewButton
    
    var showingPromoViewButton: some View{
        
        Button(action: {
            showingPromoView = true
        }){
            
            ZStack{
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.roseColor, lineWidth: 1)
                    .frame(width: 181, height: 35)
                    .blur(radius: 1 )
                HStack{
                    Image("Discount")
                    Text("Month free")
                        .foregroundColor(Color.roseColor)
                }
            }
        }
        
    }
    
    //MARK: downloadClipButton
    
    var downloadClipButton: some View {
        
        Button(action: {
            
            showModalView.position = ModalViewPosition.Download
            let tiktokFolder: URL = baseDocUrl.appendingPathComponent("tiktoks")
            let dataFolder: URL = baseDocUrl.appendingPathComponent("tiktoks/data")
            let coverFolder: URL = baseDocUrl.appendingPathComponent("tiktoks/covers")
            
            do {
                try FileManager.default.createDirectory(at: tiktokFolder, withIntermediateDirectories: true)
                try FileManager.default.createDirectory(at: dataFolder, withIntermediateDirectories: true)
                try FileManager.default.createDirectory(at: coverFolder, withIntermediateDirectories: true)
            } catch {}
            
            let strPath = baseDocUrl.appendingPathComponent("tiktoks").relativePath
            let content = try! FileManager.default.contentsOfDirectory(atPath: strPath)
            let savedList = content.filter{ ["covers", "data"].contains($0) != true }.map { $0.split(separator: ".")[0] }
          //  self.halfSheet.TikData = savedList.map { Tiktok(withFileName: String($0))  }
            
            UNUserNotificationCenter.current().delegate =  notifDelegate
            UIApplication.shared.applicationIconBadgeNumber = 0

            //    DispatchQueue.global(qos: .userInitiated).async {
            
            guard let clip = UIPasteboard.general.string else {
                showModalView.position = ModalViewPosition.Close
//                halfSheet.opasity = 0.0
                let errsNotif = Notification(text: "No URL Provided", title: "Error")
                errsNotif.execute()
                return
                
            }
            print(clip)
            let dlr = TiktokDownloader(withUrl: clip)
            
            try! dlr.download() { result in
                switch result {
                case .success(let r):
//                    self.halfSheet.TikData.append(r)
//                    halfSheet.TikData.last?.vImg!.openSheet()
                    let succesNotif = Notification(text: "Successfully downloaded", title: "Info")
                    succesNotif.execute()
                    update = true
                    showModalView.position = ModalViewPosition.Player
                    DispatchQueue.main.async {
//                        halfSheet.position = CardPosition.top
//                        halfSheet.opasity = 0.66
                    }
                case .failure(let err):
                    showModalView.position = ModalViewPosition.Close
                    DispatchQueue.main.async {
//                        halfSheet.position = CardPosition.bottom
//                        halfSheet.opasity = 0.0
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
            
            
            
        }){
            HStack{
                Image(systemName: "arrow.down.doc.fill")
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(.white)
                Text("Download clip")
                    .font(.system(size: 16, weight: .regular, design: .default))
                
            }
        }
        .roseButtonStyle()
        
        .padding(.bottom, 50)
        
    }
    
    
}



