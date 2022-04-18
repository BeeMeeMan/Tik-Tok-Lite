//
//  Downloader.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 16.01.2022.
//

import SwiftUI
import AVKit
import AVFoundation

final class Downloader: ObservableObject {

    @Published var isActiveDownload = false
    @Published var isActivePlayer = false
    @Published var TikDataTemp: Array<Tiktok> = []
    @Published var TikData: Array<Tiktok> = []
    @Published var playlistArray: Array<PlaylistData> = []
    
    init() {
//        let defaults = UserDefaults.standard
//        if let plistArr = defaults.object(forKey: "plistArr") as? Data {
//            let decoder = JSONDecoder()
//            if let loadedPlistArr = try? decoder.decode(Array<PlaylistData>.self, from: plistArr) {
//                self.playlistArray = loadedPlistArr
//            }
//        }
    }
    
   func loadTikTokData() {
        let strPath = FileManager.documentsDirectory().appendingPathComponent("tiktoks").relativePath
        let content = try! FileManager.default.contentsOfDirectory(atPath: strPath)
        let savedList = content.filter{ ["covers", "data"].contains($0) != true }.map { $0.split(separator: ".")[0] }
        DispatchQueue.main.async {
            self.TikData = savedList.map { Tiktok(withFileName: String($0))  }
            print(savedList.count)
//            UNUserNotificationCenter.current().delegate =  notifDelegate
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}
