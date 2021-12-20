//
//  ModalView.swift
//  CustomModalPopup
//
//  Created by Fantom on 15.12.2021.
//

import SwiftUI

class ShowModalView: ObservableObject {
    
    @Published var isActiveDownload = false
    @Published var isActivePlayer = false
    @Published var TikData: Array<Tiktok> = []
    
    
}



struct ModalView: View {
    
    //DOwnloader:
    @State var update = false
    @StateObject var notifDelegate = NotificationDelegate()
    
    @EnvironmentObject var showModalView: ShowModalView
    
    @State private var isDragging = false
    @State private var curHeight: CGFloat = 400
    
    let minHeight: CGFloat = 400
    let maxHeight: CGFloat = 800
    
    let startOpacity = 0.4
    let endOpacity = 0.8
    
    var dragPercentage: Double {
        
        let res = Double((curHeight - minHeight) / (maxHeight - minHeight))
        
        return max(0, min(1, res))
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            
            if showModalView.isActiveDownload{
                
            Color.black
                .opacity(startOpacity + (endOpacity - startOpacity) * dragPercentage)
                .ignoresSafeArea()
                .onTapGesture {
                    
                    withAnimation(.easeInOut) {
                        
                        showModalView.isActiveDownload = false
                        
                    }
                }
               
                    downloadView
            .transition(.move(edge: .bottom))
               
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        
    
        
    }
            

// MARK: - downloadView
    
    var downloadView: some View{
        
        VStack{
            // Handle
            
            ZStack{
                Capsule()
                    .foregroundColor(Color.lightGray)
                    .frame(width: 40, height:  6)
              
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.000001))  // important for the dragging
            .gesture(dragGesture)
            
            ZStack{
                Color.barBackgroundGrey
                  
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
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
            
           
        }
        .frame(height: curHeight)
        .frame(maxWidth:.infinity)
        .background(
        //Hack for corderRadius only on top
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.barBackgroundGrey)
                Rectangle()
                    .frame(height: curHeight / 2)
            }
                .foregroundColor(Color.white)
        )
       // .animation(isDragging ? nil : .easeInOut(duration: 0.45))
        .onAppear() {
            
            showModalView.isActiveDownload = true
        
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
                showModalView.isActiveDownload = false
               
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
                    self.showModalView.TikData = []
                    self.showModalView.TikData.append(r)
//                    halfSheet.TikData.last?.vImg!.openSheet()
                    let succesNotif = Notification(text: "Successfully downloaded", title: "Info")
                    succesNotif.execute()
                    update = true
                    
              //      showModalView.isActive = true
                    DispatchQueue.main.async {
                        if showModalView.isActiveDownload != false{
                        showModalView.isActiveDownload = false
                        showModalView.isActivePlayer = true
                        }
                    }
                case .failure(let err):
                 //   showModalView.isActive = false
                    DispatchQueue.main.async {
                       showModalView.isActiveDownload = false
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
        
        
        .onDisappear {
            
            curHeight = minHeight
        }
    }
        @State private var prevDragTranslation = CGSize.zero
        
        var dragGesture: some Gesture{
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged { val in
                    
                    if !isDragging{
                        isDragging = true
                    }
                    let dragAmount = val.translation.height - prevDragTranslation.height
                    
                    if curHeight > maxHeight || curHeight < minHeight{
                        curHeight -= dragAmount / 6
                    } else {
                        curHeight -= dragAmount
                    }
                   
                    prevDragTranslation = val.translation
                }
                .onEnded { val in
                    withAnimation(.easeInOut(duration: 0.4)) {
                    prevDragTranslation = .zero
                    isDragging = false
                    if curHeight > maxHeight {
                        curHeight = maxHeight
                    }
                    if curHeight < minHeight {
                        curHeight = minHeight
                    }
                    }
                }
            
            
        }
    
}



struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
