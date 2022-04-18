//
//  TikTokData.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 10.04.2022.
//

import Foundation

struct TiktokData: Identifiable {
    var id = UUID().uuidString
    var data: Welcome? = nil
    var fileName: String
    var coverFile: String
    var dataFile: String
    
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
            let dataFileUrl = FileManager.documentsDirectory().appendingPathComponent("tiktoks/data/\(dataFile)")
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
            return FileManager.documentsDirectory().appendingPathComponent("tiktoks/\(fileName)")
        case .data:
            return FileManager.documentsDirectory().appendingPathComponent("tiktoks/data/\(dataFile)")
        case .cover:
            return FileManager.documentsDirectory().appendingPathComponent("tiktoks/covers/\(coverFile)")
        }
    }
    
    public mutating func loadCover() {
//        if let data = data {
//            vImg = VImageLoader(withUrl: url(forFile: .cover).relativeString , width: 160, height: 160, data: data, withVideoUrl: url(forFile: .video), bundleNames: ["f": fileName, "d": dataFile, "c": coverFile], sheet: SheetObservable())
//        }
    }
    
    public func delete() {
        do {
            try FileManager.default.removeItem(at: self.url(forFile: .video))
            try FileManager.default.removeItem(at: self.url(forFile: .data))
            try FileManager.default.removeItem(at: self.url(forFile: .cover))
        } catch {
            print("Could not delete file: \(error)")
        }
    }
}
