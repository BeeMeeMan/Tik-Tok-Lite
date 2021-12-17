
//  Stollen by JK 20/11/2021.

import SwiftUI
import Photos
import AVKit
import AVFoundation


struct Welcome: Codable {
    let props: Props
    
    struct Video: Codable {
        let playAddr: String
        let downloadAddr: String
        let cover: String
    }
    
    struct Author: Codable {
        let nickname: String
    }
    
    struct ItemStruct: Codable {
        let video: Video
        let author: Author
        let desc, id: String
        let createTime: Int
    }
    
    struct ItemInfo: Codable {
        let itemStruct: ItemStruct
    }
    
    struct PageProps: Codable {
        let itemInfo: ItemInfo
    }
    
    struct Props: Codable {
        let pageProps: PageProps
    }
}

enum downloaderErrors: Error {
    case InvalidUrlGiven
    case JsonScrapFailed
    case JsonParseFailed
    case DownloadVideoForbiden
    case VideoDownloadFailed
    case VideoSaveFailed
    case CoverSaveFailed
}

class TiktokDownloader {
    let videoUrl: String
    var fileName: String? = nil
    var coverFile: String? = nil
    var dataFile: String? = nil
    
    var img: VImageLoader? = nil
    
    init(withUrl: String) {
        videoUrl = withUrl
        //try! self.download() { result in }
    }
    
    private func scrapJson(content: String) -> String? {
        var json: String?
        var jsond = content.components(separatedBy: "id=\"__NEXT_DATA__\"")
        if jsond.indices.contains(1) {
            jsond = jsond[1].components(separatedBy: "crossorigin=\"anonymous\">")
            if jsond.indices.contains(1) {
                jsond = jsond[1].components(separatedBy: "</script>")
                if jsond.indices.contains(0) {
                    json = jsond[0]
                } else { json = nil }
            } else { json = nil  }
        } else { json = nil  }
        
        return json
    }
    
    
    
    public func download(completion: @escaping (Result<Tiktok, downloaderErrors>) -> Void) throws {
        
        guard let url = URL(string: videoUrl) else {
            completion(.failure(.InvalidUrlGiven))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Safari/605.1.15", forHTTPHeaderField: "User-Agent")
        request.setValue("https://www.tiktok.com/", forHTTPHeaderField: "Referer")
        request.setValue("bytes=0-", forHTTPHeaderField: "Range")
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                let html = String(data: data, encoding: .utf8)!
                
                guard let json = self.scrapJson(content: html) else {
                    completion(.failure(.JsonScrapFailed))
                    return
                }
                
                let data = String(json).data(using: .utf8)!
                
                let dot: Welcome?
                do {
                    dot = try JSONDecoder().decode(Welcome.self, from: data)
                } catch {
                    completion(.failure(.JsonParseFailed))
                    return
                }
                
                guard let dot = dot else {
                    completion(.failure(.JsonParseFailed))
                    return
                }
                
                let videoId = dot.props.pageProps.itemInfo.itemStruct.id
                let videoCreatedTime = dot.props.pageProps.itemInfo.itemStruct.createTime
                
                self.dataFile = "\(videoId)-\(videoCreatedTime).json"
                let UUU: URL = baseDocUrl.appendingPathComponent("tiktoks/data/\(self.dataFile!)")
                let jsonData = try! JSONEncoder().encode(dot)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                try! jsonString.write(to: UUU, atomically: true, encoding: .utf8)
                
                let dlAddr = dot.props.pageProps.itemInfo.itemStruct.video.downloadAddr
                request.url = URL(string: dlAddr)!
                HTTPCookieStorage.shared.setCookie(HTTPCookie(properties: [.domain: dlAddr, .path: "/", .name: "tt_webid", .value: "6972893547414586885", .secure: "FALSE", .discard: "TRUE"])!)
                HTTPCookieStorage.shared.setCookie(HTTPCookie(properties: [.domain: dlAddr, .path: "/", .name: "tt_webid_v2", .value: "6972893547414586885", .secure: "FALSE", .discard: "TRUE"])!)
                
                let videoTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode == 206 {
                            if let data = data {
                                
                                self.fileName = "\(videoId)-\(videoCreatedTime).mp4"
                                let UUU: URL = baseDocUrl.appendingPathComponent("tiktoks/\(self.fileName!)")
                                print("downloading \(self.fileName!)")
                                do {
                                    try data.write(to: UUU)
                                    //try self.saveToPhotos()
                                } catch {
                                    completion(.failure(.VideoSaveFailed))
                                    return
                                }
                                completion(.success(Tiktok(withFileName: "\(videoId)-\(videoCreatedTime)", withData: dot)))
                                
                            }
                        } else {
                            completion(.failure(.DownloadVideoForbiden))
                        }
                    }
                }
                videoTask.resume()
                
                let coverAddr = dot.props.pageProps.itemInfo.itemStruct.video.cover
                request.url = URL(string: coverAddr)!
                HTTPCookieStorage.shared.setCookie(HTTPCookie(properties: [.domain: coverAddr, .path: "/", .name: "tt_webid", .value: "6972893547414586885", .secure: "FALSE", .discard: "TRUE"])!)
                HTTPCookieStorage.shared.setCookie(HTTPCookie(properties: [.domain: coverAddr, .path: "/", .name: "tt_webid_v2", .value: "6972893547414586885", .secure: "FALSE", .discard: "TRUE"])!)
                
                let imageTask = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        
                        self.coverFile = "\(videoId)-\(videoCreatedTime).jpg"
                        let UUU: URL = baseDocUrl.appendingPathComponent("tiktoks/covers/\(self.coverFile!)")
                        print("downloading cover\(self.coverFile!)")
                        do {
                            try data.write(to: UUU)
                            //try self.saveToPhotos()
                        } catch {
                            completion(.failure(.CoverSaveFailed))
                            return
                        }
                    }
                }
                imageTask.resume()
            }
        }
        dataTask.resume()
    }
}


struct Tiktok {
    var data: Welcome? = nil
    var fileName: String
    var coverFile: String
    var dataFile: String
    var vImg: VImageLoader? = nil
    
    enum fileType {
        case data
        case video
        case cover
    }
    
    init(withFileName: String, withData: Welcome? = nil) {
        fileName = "\(withFileName).mp4"
        coverFile = "\(withFileName).jpg"
        dataFile = "\(withFileName).json"
        
        if withData == nil {
            let dataFileUrl = baseDocUrl.appendingPathComponent("tiktoks/data/\(dataFile)")
            let dataFile = try! String(contentsOfFile: dataFileUrl.relativePath)
            
            data = try! JSONDecoder().decode(Welcome.self, from: dataFile.data(using: .utf8)!)
        } else {
            
            data = withData
        }
        loadCover()
    }
    
    public func url(forFile: fileType) -> URL {
        
        switch forFile {
        case .video:
            return baseDocUrl.appendingPathComponent("tiktoks/\(fileName)")
        case .data:
            return baseDocUrl.appendingPathComponent("tiktoks/data/\(dataFile)")
        case .cover:
            return baseDocUrl.appendingPathComponent("tiktoks/covers/\(coverFile)")
        }
    }
    
    public mutating func loadCover(){
        if let data = data {
            vImg = VImageLoader(withUrl: url(forFile: .cover).relativeString , width: 160, height: 160, data: data, withVideoUrl: url(forFile: .video), bundleNames: ["f": fileName, "d": dataFile, "c": coverFile], sheet: SheetObservable())
        }
    }
    
}



struct TikTokVideoURL {
    
    public var withUrl: String
    private var loaded: Bool
    @State private var imgData: UIImage? = nil
    @ObservedObject var Sheet: SheetObservable
    @State var deleted = false
    
    var data: Welcome
    let videoUrl: URL
    var videoPlayer: AVPlayer
    var bundleNames: [String: String]
    @State var playerState = false
    @State var playerTime: CMTime = CMTime(seconds: 0, preferredTimescale: 0)
    public var width: CGFloat
    public var height: CGFloat
    
    init(withUrl: String, width: CGFloat, height: CGFloat, data: Welcome, withVideoUrl: URL, bundleNames: [String:String], sheet: SheetObservable) {
        
        self.withUrl = withUrl
        self.loaded = false
        self.width = width
        self.height = height
        self.data = data
        self.videoUrl = withVideoUrl
        self.videoPlayer = AVPlayer(url:  videoUrl)
        self.Sheet = sheet
        self.bundleNames = bundleNames

    }
    
    
    public func openSheet() {
        print("openSheet fired()")
        self.Sheet.isActive = true
    }
    
    public func saveToPhotos() throws {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoUrl)
        }) { saved, error in
            if saved {
                let succesNotif = Notification(text: "Successfully saved to photo", title: "Info")
                succesNotif.execute()
            }
            if (error != nil) {
                let errNotif = Notification(text: "Failed to save to photo", title: "Error")
                errNotif.execute()
            }
        }
    }
    
    func getImage() {
        let url = URL(string: withUrl)!
        let data = try! Data(contentsOf: url)
        self.imgData = UIImage(data:data)!
    }
    
    
    
}
struct VImageLoader: View {
    
    public var withUrl: String
    private var loaded: Bool
    @State private var imgData: UIImage? = nil
    @ObservedObject var Sheet: SheetObservable
    @State var deleted = false
    
    var data: Welcome
    let videoUrl: URL
    var videoPlayer: AVPlayer
    var bundleNames: [String: String]
    @State var playerState = false
    @State var playerTime: CMTime = CMTime(seconds: 0, preferredTimescale: 0)
    public var width: CGFloat
    public var height: CGFloat
    
    init(withUrl: String, width: CGFloat, height: CGFloat, data: Welcome, withVideoUrl: URL, bundleNames: [String:String], sheet: SheetObservable) {
        
        self.withUrl = withUrl
        self.loaded = false
        self.width = width
        self.height = height
        self.data = data
        self.videoUrl = withVideoUrl
        self.videoPlayer = AVPlayer(url:  videoUrl)
        self.Sheet = sheet
        self.bundleNames = bundleNames

    }
    
    
    public func openSheet() {
        print("openSheet fired()")
        self.Sheet.isActive = true
    }
    
    public func saveToPhotos() throws {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoUrl)
        }) { saved, error in
            if saved {
                let succesNotif = Notification(text: "Successfully saved to photo", title: "Info")
                succesNotif.execute()
            }
            if (error != nil) {
                let errNotif = Notification(text: "Failed to save to photo", title: "Error")
                errNotif.execute()
            }
        }
    }
    
    func getImage() {
        let url = URL(string: withUrl)!
        let data = try! Data(contentsOf: url)
        self.imgData = UIImage(data:data)!
    }
    
    
   
  
  
    
    var body: some View {

        if deleted {
            
        } else {
            if imgData != nil {
//                Image(uiImage: imgData!)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: UIScreen.width, height: UIScreen.height)
//                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
//                    .shadow(radius: 7)
//                    .sheet(isPresented: $Sheet.isActive, content: {
//                    Text(data.props.pageProps.itemInfo.itemStruct.author.nickname)
//
//                            .font(.title)
//                            .bold()
//                            .padding(.top, 10)
//                        Spacer()
                ZStack{
                       // VideoPlayer(player: videoPlayer)
                      
                   // VideoPlayer(player: $player)
//                    if !playerState{
//                        Image("PlayCircle")
//                    }
                
                }
                          //.aspectRatio(contentMode: .fill)
               
                            
//                            .frame(width: UIScreen.width * 0.92, height: UIScreen.height * 0.7)
//                            .clipShape(RoundedRectangle(cornerRadius: 14))
//                            .shadow(radius: 7)
//                            .onAppear() {
//                                playerTime = (videoPlayer.currentItem?.asset.duration)!
//                                videoPlayer.play()
//                                videoPlayer.actionAtItemEnd = .none
//                                //videoPlayer.videoGravity = .resizeAspectFill
//                                playerState.toggle()
//
//                            }
//                            .onDisappear() {
//                                videoPlayer.pause()
//                                videoPlayer.seek(to: .zero)
//
//                            }
//                            .onTapGesture {
//                                if playerState {
//                                    videoPlayer.pause()
//                                    playerState.toggle()
//                                } else {
//                                    videoPlayer.play()
//                                    playerState.toggle()
//                                }
//                            }
                        
                        
                        
                        
//                    })
                    .onTapGesture  {
                      //  UINotificationFeedbackGenerator().notificationOccurred(.success)
                      //  self.Sheet.isActive.toggle()
                    }
//                    .contentShape(RoundedRectangle(cornerRadius:25))
//                    .contextMenu {
//                        VStack {
//                            Button(action: {
//                                try! saveToPhotos()
//                                UINotificationFeedbackGenerator().notificationOccurred(.success)
//                            }) {
//                                Label("Save to photo", systemImage: "square.and.arrow.down")
//                            }
//                            Button(action: {
//                                try! FileManager.default.removeItem(at: baseDocUrl.appendingPathComponent("tiktoks/\(bundleNames["f"]!)"))
//                                try! FileManager.default.removeItem(at: baseDocUrl.appendingPathComponent("tiktoks/data/\(bundleNames["d"]!)"))
//                                try! FileManager.default.removeItem(at: baseDocUrl.appendingPathComponent("tiktoks/covers/\(bundleNames["c"]!)"))
//
//                                deleted = true
//                                UINotificationFeedbackGenerator().notificationOccurred(.success)
//                            }, label: {
//                                Label("Delete", systemImage: "trash").background(Color(.red))
//
//                            })
//
//                        }
//                    }
            } else {
                Image("1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                    .shadow(radius: 7)
                    .onAppear {
                        if imgData == nil {
                            DispatchQueue.global(qos: .userInitiated).async {
                                self.getImage()
                            }
                        }
                    }
            }
        }
        
        
        
        
    }
    
}

class SheetObservable: ObservableObject {
    @Published var isActive = false
}


















