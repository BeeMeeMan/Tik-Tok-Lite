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


struct DownloadTabView: View {
    
    @EnvironmentObject var downloader: Downloader
    @State private var showingPromoView = false
    @State var showingInfoView = false
    @State private var showDownloadAndPlayView = false
    @StateObject var notifDelegate = NotificationDelegate()
    @Binding var showDownloadPopUpView: Bool
    
    //New modalView:
        //   @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    
    @State var showingPlayerView = false
    
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

            .fullScreenCover(isPresented: $showingPromoView) {
                PromotionTabView()
            }
            .fullScreenCover(isPresented: $showingInfoView){
                IntroTabView()
            }
            .popover(isPresented: $showDownloadAndPlayView) {
                DownloadAndPlayView(player: AVPlayer(url: (downloader.TikDataTemp.last?.url(forFile: .video))! ))
            }
            
            
            
        }
        
        .onAppear() {
            DispatchQueue.global(qos: .userInitiated).async {
            print("Appear")
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
           // print(content)
            let savedList = content.filter{ ["covers", "data"].contains($0) != true }.map { $0.split(separator: ".")[0] }
           // print(savedList)
                DispatchQueue.main.async {
                     downloader.TikData = savedList.map { Tiktok(withFileName: String($0))  }
                    // print(downloader.TikData)
                     
                     UNUserNotificationCenter.current().delegate =  notifDelegate
                     UIApplication.shared.applicationIconBadgeNumber = 0
                     
                }
           
          
        }
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
         //   withAnimation(.spring()) {
                
                showDownloadPopUpView = true
                    
            //    }
                
            
            
            
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
        .fullScreenCover(isPresented:  $showDownloadPopUpView, onDismiss: ({
            if !downloader.TikDataTemp.isEmpty {
            showDownloadAndPlayView = true
            }
        })){
            
            DownloadPopUpView(isLoading: true).environmentObject(self.downloader)
        }
    
    }

    
    
}



