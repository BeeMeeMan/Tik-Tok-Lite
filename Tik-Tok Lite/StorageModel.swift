//
//  PlaylistsStorage.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 09.04.2022.
//

import SwiftUI

extension String: LocalizedError {
    public var errorDescription: String? {
        return self
    }
}

final class StorageModel: ObservableObject {
    @Published var playlistArray: [PlaylistData] = []
    @Published var listCover: [UIImage?] = []
    @Published var tiktokTemp: Tiktok? = nil
    
    init() {
        createDir()
        loadPlaylistData()
        loadPlaylistCovers()
        //        let defaults = UserDefaults.standard
        //        if let plistArr = defaults.object(forKey: "plistArr") as? Data {
        //            let decoder = JSONDecoder()
        //            if let loadedPlistArr = try? decoder.decode(Array<PlaylistData>.self, from: plistArr) {
        //                self.playlistArray = loadedPlistArr
        //            }
        //        }
    }
    
    public func deletePlaylist(index: Int) {
        if listCover[index] != nil {
            UIImage.remove(filename: playlistArray[index].name)
        }
        playlistArray.remove(at: index)
        listCover.remove(at: index)
        savePlaylistData()
    }
    
    public func savePlaylist(at index: Int?, plistName: String, plistDiscription: String, image: UIImage?) {
        if plistName != ""{
            var newIndex = 0
            if index == nil {
                newIndex = playlistArray.endIndex
                playlistArray.append(PlaylistData(name: plistName, description: plistDiscription ))
                listCover.append(nil)
            } else {
                newIndex = index!
                playlistArray[newIndex] = PlaylistData(name: plistName, description: plistDiscription)
            }
            
            if let image = image {
                listCover[newIndex] = image
                image.save(to: plistName)
                loadPlaylistCovers()
            }
            savePlaylistData()
        }
    }
    
    //    func addTikTok(_ video: , to playlist: String) {
    //      //  let newItem = self.downloader.TikDataTemp.last!
    //
    //        let index = playlistArray.firstIndex(of: playlist)
    //        playlistArray[index].append(newItem.fileName)
    //    dataStorage
    //        savePlaylistArray(downloader.playlistArray)
    //        self.downloader.TikData.append(newItem)
    //    }
    
    public func createDir() {
        let tiktokFolder: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks")
        let dataFolder: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/data")
        let coverFolder: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/covers")
        let platlistFolder: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/playlist")
        
        do {
            try FileManager.default.createDirectory(at: tiktokFolder, withIntermediateDirectories: true)
            try FileManager.default.createDirectory(at: dataFolder, withIntermediateDirectories: true)
            try FileManager.default.createDirectory(at: coverFolder, withIntermediateDirectories: true)
            try FileManager.default.createDirectory(at: platlistFolder, withIntermediateDirectories: true)
        } catch { }
    }
    
    private func loadPlaylistCovers() {
        for playlist in playlistArray {
            listCover.append(UIImage.load(filename: playlist.name))
            print("LoadCover")
        }
    }
    
    func loadPlaylistData() {
        let path = FileManager.documentsDirectory().appendingPathComponent("tiktoks/playlist/playlisData.json")
        if let data = try? Data(contentsOf: path) {
            let decoder = JSONDecoder()
            do {
                playlistArray = try decoder.decode(
                    [PlaylistData].self,
                    from: data)
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
    
    private func savePlaylistData() {
        let encoder = JSONEncoder()
        let platlistDataURL: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/playlist/playlisData.json")
        do {
            let data = try encoder.encode(playlistArray)
            try data.write(
                to: platlistDataURL,
                options: Data.WritingOptions.atomic)
        } catch { // 6
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    //        let encoder = JSONEncoder()
    //        if let encoded = try? encoder.encode(playlistArray) {
    //            let defaults = UserDefaults.standard
    //            defaults.set(encoded, forKey: "plistArr")
    //            print("save")
    //        }
    //    }
    
    
    
    static func downloadTikTok(by videoUrl: String) async throws -> Tiktok {
        guard let url = URL(string: videoUrl) else {
            throw "Could not create the URL."
        }
        
        var request = URLRequest(url: url)
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.1 Safari/605.1.15", forHTTPHeaderField: "User-Agent")
        request.setValue("https://www.tiktok.com/", forHTTPHeaderField: "Referer")
        request.setValue("bytes=0-", forHTTPHeaderField: "Range")
        print(request)
        //
        //      await addDownload(name: file.name)
        
        let (data, response) = try await
        URLSession.shared.data(for: request)
        
        //      await updateDownload(name: file.name, progress: 1.0)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "The server responded with an error."
        }
        
        print("Data: \(data)")
        
        func scrapJson(content: String) -> String? {
                              var json: String?
                              var jsond = content.components(separatedBy: "\"ItemModule\":")
        
                              if jsond.indices.contains(1) {
                                  let jsonTemp = jsond[1]
        
                                  if let i = jsonTemp.firstIndex(of: "i") {
                                      jsond[1] = String(jsonTemp.suffix(from: i))
                                      jsond[1] = "{\"" +  jsond[1]
                                  }
        
                                  jsond = jsond[1].components(separatedBy: "},\"UserModule\"")
                                  if jsond.indices.contains(0) {
                                      json = jsond[0]
                                  } else { json = nil }
        
                              } else { json = nil }
        
                              return json
                          }
        
        
            let html = String(data: data, encoding: .utf8)!
            guard let json = scrapJson(content: html) else {
                throw "Scrap error."
            }

            let newData = String(json).data(using: .utf8)!
            let dot: Welcome?
            do {
                dot = try JSONDecoder().decode(Welcome.self, from: newData)
            } catch {
                throw "JsonParseFailed"
            }

            guard let dot = dot else {
               throw "JsonParseFailed"
            }

            let videoId = dot.id
            let videoCreatedTime = dot.createTime

            let dataFile = "\(videoId)-\(videoCreatedTime).json"
            let dataFileURL: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/data/\(dataFile)")
            let jsonData = try! JSONEncoder().encode(dot)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            try! jsonString.write(to: dataFileURL, atomically: true, encoding: .utf8)
            let dlAddr = dot.video.downloadAddr
            print("Download adrr: \(dlAddr)")
        
            request.url = URL(string: dlAddr)!
            print("start url session")
        
        let (videoData, videoResponse) = try await URLSession.shared.data(for: request)
        
        guard (videoResponse as? HTTPURLResponse)?.statusCode == 206 else {
            throw "The server responded with an error."
        }
        let fileName = "\(videoId)-\(videoCreatedTime).mp4"
        let fileURL: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/\(fileName)")
        print(fileURL)
        print("downloading \(fileName)")
        do {
            try videoData.write(to: fileURL)
        } catch {
            throw "Video save failed"
        }
        
        print("Video is saved")

            let coverAddr = dot.video.cover
            request.url = URL(string: coverAddr)!
        let (imageData, imageResponse) = try await URLSession.shared.data(for: request)

                    let coverFile = "\(videoId)-\(videoCreatedTime).jpg"
                    let imageURL: URL = FileManager.documentsDirectory().appendingPathComponent("tiktoks/covers/\(coverFile)")
                    print("downloading cover\(coverFile)")
        
        guard (imageResponse as? HTTPURLResponse)?.statusCode == 206 else {
            throw "Cover download end with an error."
        }
                    do {
                        try imageData.write(to: imageURL)
                    } catch {
                       throw "Cover save failed"
                    }
        
        print("all ended")
        Notification.videoDownloadWasSuccessful()
        return Tiktok(withFileName: "\(videoId)-\(videoCreatedTime)", withData: dot, player: nil)
    }
}
