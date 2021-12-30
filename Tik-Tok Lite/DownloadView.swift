//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//


import SwiftUI
import AVKit
import AVFoundation

class Downloader: ObservableObject {
    
    @Published var isActiveDownload = false
    @Published var isActivePlayer = false
    @Published var isDownloadedSucsess = false
    @Published var TikDataTemp: Array<Tiktok> = []
    @Published var TikData: Array<Tiktok> = []
    @Published var plistArr: Array<Playlist> = []
    
    init(){
        let defaults = UserDefaults.standard
        if let plistArr = defaults.object(forKey: "plistArr") as? Data {
            let decoder = JSONDecoder()
            if let loadedPlistArr = try? decoder.decode(Array<Playlist>.self, from: plistArr) {
                self.plistArr = loadedPlistArr
            }
        }
        
    }
}



var size: CGFloat = 160
let baseDocUrl = try! FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)


struct DownloadView: View {
    
    @EnvironmentObject var downloader: Downloader
    @State private var showingPromoView = false
    @State var showingInfoView = false
    // @State var update = false
    @StateObject var notifDelegate = NotificationDelegate()
    //    @EnvironmentObject var halfSheet: HalfSheetPosition
    //    @EnvironmentObject var TikData: HalfSheetPosition
    
    // Show download animation
    //@State private var showModalPopUpView = false
    
    //New modalView:
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    
    @State var showingPlayerView = false
    
    //@State var player = AVPlayer(url: URL(string: "https://www.rmp-streaming.com/media/big-buck-bunny-360p.mp4")!)
    
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
            .fullScreenCover(isPresented: $showingPromoView) {
                PromotionTabView()
            }
            .fullScreenCover(isPresented: $showingInfoView){
                IntroTabView()
            }
            .popover(isPresented: $downloader.isDownloadedSucsess) {
                DownloadAndPlayView(player: AVPlayer(url: (downloader.TikDataTemp.last?.url(forFile: .video))! ))
            }
            
            
            
        }
        
        .onAppear() {
            
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
            print(content)
            let savedList = content.filter{ ["covers", "data"].contains($0) != true }.map { $0.split(separator: ".")[0] }
            print(savedList)
            downloader.TikData = savedList.map { Tiktok(withFileName: String($0))  }
            print(downloader.TikData)
            
            UNUserNotificationCenter.current().delegate =  notifDelegate
            UIApplication.shared.applicationIconBadgeNumber = 0
            
            //            if downloader.isDownloadedSucsess{
            //
            //                player = AVPlayer(url: (downloader.TikDataTemp.last?.url(forFile: .video))! )
            //                showingPlayerView = true
            //
            //               // downloader.isDownloadedSucsess = false
            //            }
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
            withAnimation(.easeInOut) {
                self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
                    DownloadPopUpView().environmentObject(self.downloader)
                        .transition(.move(edge: .bottom))
                    
                }
                
            }
            
            
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
    
    
    
    //    struct ModalPopUpView: View {
    //
    //        @Binding var showModalPopUpView: Bool
    //        @State private var value = 0.0
    //
    //        @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    //
    //        var body: some View {
    //
    //                ZStack{
    //                    Color.barBackgroundGrey
    //                        .opacity(0.1)
    //                        .onTapGesture {
    //                            withAnimation(.easeInOut) {
    //                                showModalPopUpView = false
    //                            self.viewControllerHolder?.dismiss(animated: true, completion: nil)
    //                            }
    //                        }
    //                    VStack{
    //                        Spacer()
    //                            VStack {
    //                                Spacer()
    //                                HStack{
    //                                    Spacer()
    //                                    ProgressView()
    //                                        .scaleEffect(1.5)
    //                                    Spacer()
    //                                }
    //                                .padding(.bottom, 10)
    //                                Text("Clip is downloading")
    //                                Spacer()
    //
    //                            }
    //
    //
    //                        .background(Color.barBackgroundGrey).clipShape(RoundedRectangle(cornerRadius: 22))
    //                        .frame(height: UIScreen.height * 0.3)
    //                        .frame(maxWidth:.infinity)
    //
    //                    }
    //
    //                }
    //                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    //                .ignoresSafeArea()
    //                .onAppear(){
    //                    showModalPopUpView = true
    //                }
    //
    //        }
    //
    //    }
    
    
    //    func downloadVideo(){
    //
    //        guard let clip = UIPasteboard.general.string else {
    //
    //
    //            let errsNotif = Notification(text: "No URL Provided", title: "Error")
    //            errsNotif.execute()
    //            DispatchQueue.main.async {
    //            self.viewControllerHolder?.dismiss(animated: true, completion: nil)
    //            }
    //            return
    //
    //        }
    //        print(clip)
    //        let dlr = TiktokDownloader(withUrl: clip)
    //
    //        try! dlr.download() { result in
    //            switch result {
    //            case .success(let r):
    //                DispatchQueue.main.async {
    //                    if showModalPopUpView{
    //                self.downloader.TikDataTemp = []
    //                self.downloader.TikDataTemp.append(r)
    ////                    halfSheet.TikData.last?.vImg!.openSheet()
    //                let succesNotif = Notification(text: "Successfully downloaded", title: "Info")
    //                succesNotif.execute()
    //                update = true
    //
    //          //      showModalView.isActive = true
    //                player = AVPlayer(url: (downloader.TikDataTemp.last?.url(forFile: .video))! )
    //                showingPlayerView = true
    //                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
    //                    } else {
    //                        self.viewControllerHolder?.dismiss(animated: true, completion: nil)
    //                    }
    //                }
    //                   // showModalView.isActivePlayer = true
    //
    //            case .failure(let err):
    //             //   showModalView.isActive = false
    //                DispatchQueue.main.async {
    //                self.viewControllerHolder?.dismiss(animated: true, completion: nil)
    //                }
    //                switch err {
    //
    //                case .InvalidUrlGiven:
    //                    let errsNotif = Notification(text: "The url you gave is incorrect", title: "Error")
    //                    errsNotif.execute()
    //
    //                case .VideoSaveFailed, .DownloadVideoForbiden, .VideoDownloadFailed:
    //                    let errsNotif = Notification(text: "Failed to download video", title: "Error")
    //                    errsNotif.execute()
    //
    //
    //                default:
    //                    let errsNotif = Notification(text: "Generic error", title: "Error")
    //                    errsNotif.execute()
    //
    //
    //                }
    //            }
    //
    //        }
    //        UINotificationFeedbackGenerator().notificationOccurred(.success)
    //
    //
    //
    //    }
    
    
}



