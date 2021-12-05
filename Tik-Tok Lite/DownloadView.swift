//
//  DownloadView.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 10/29/21.
//

import SwiftUI




struct DownloadView: View {
    
    @State private var showingPromo = false
    
    @State private var showingDownloadPopupView = false
    
    @State private var showingDownloadAnimationView = false
    
    // Change @State to @StateObject and Tiktok struct change to class, to observe
    @State var showSheet: Bool = false
    
    @StateObject var notifDelegate = NotificationDelegate()
    
    // min | size
    // 120 | 160 -> 2
    // 110 | 105 -> 3
    // 80  | 75  -> 4
    // UIScreen.main.bounds.size.width - 25 | 200 -> 1
    
    
    
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
                        Button(action: {
                            showingPromo = true
                        }){
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.roseColor, lineWidth: 1)
                                    .frame(width: 181, height: 35)
                                // .blendMode(.destinationOut)
                                    .blur(radius: 1 )
                                HStack{
                                    Image("Discount")
                                    Text("Month free")
                                        .foregroundColor(Color.roseColor)
                                }
                            }
                        }
                        
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
                    Button(action: {
                        
                        //                        DispatchQueue.global(qos: .userInitiated).async {
                        //                            print("eeee")
                        //                            guard let clip = UIPasteboard.general.string else {
                        //                                return
                        //                            }
                        //                            print(clip)
                        //                            let dlr = TiktokDownloader(withUrl: clip)
                        //                            try! dlr.download() { result in
                        //                                switch result {
                        //                                case .success(let r):
                        //                                    self.TikData.append(r)
                        //                                    let succesNotif = Notification(text: "Successfully downloaded", title: "Info")
                        //                                    succesNotif.execute()
                        //                                case .failure(let err):
                        //                                    switch err {
                        //                                    case .InvalidUrlGiven:
                        //                                        let errsNotif = Notification(text: "The url you gave is incorrect", title: "Error")
                        //                                        errsNotif.execute()
                        //                                    case .VideoSaveFailed, .DownloadVideoForbiden, .VideoDownloadFailed:
                        //                                        let errsNotif = Notification(text: "Failed to download video", title: "Error")
                        //                                        errsNotif.execute()
                        //                                    default:
                        //                                        let errsNotif = Notification(text: "Generic error", title: "Error")
                        //                                        errsNotif.execute()
                        //                                    }
                        //                                }
                        //                            }
                        //                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        //                        }
                        //TikData.last?.vImg(sheet: self.Sheet).openSheet()
                        showSheet.toggle()
                        //                        showingDownloadAnimationView = true
                        //
                        //                                // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
                        //                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        //
                        //                                showingDownloadAnimationView = false
                        //                                showingDownloadPopupView = true
                        //
                        //                                    }
                        
                    })
                    
                    
                    
                    
                    {
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
                
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Image(systemName: "exclamationmark.circle.fill")
                                        .foregroundColor(.roseColor))
                .navigationTitle("Download clip")
                .font(.system(size: 16, weight: .regular, design: .default))
                
                
            }
            .fullScreenCover(isPresented: $showingPromo, content: PromotionTabView.init)
            
            .halfSheet(showSheet: $showSheet){
                VStack {
                    HStack{
                        Spacer()
                        ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .scaleEffect(2)
                        Spacer()
                    }
                    .padding(.top, UIScreen.height * 0.2)
                    .padding(.bottom, 40)
                    Text("Clip is downloading")
                        .foregroundColor(Color.white)
                    Spacer()
                }
                
                .background(Color(red: 0.18, green: 0.176, blue: 0.176))
                
                .ignoresSafeArea()
            } onEnd: {
                print("Dissmissed")
            }
            
            
        }
        
        
        
        
        .popover(isPresented: $showingDownloadPopupView) {
            
            DownloadPopupView()
            
            
            
        }
        
        .popover(isPresented: $showingDownloadAnimationView){
            
            
            
            
        }
    }
    
    
}



