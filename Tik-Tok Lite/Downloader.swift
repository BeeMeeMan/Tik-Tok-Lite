//
//  Downloader.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 16.01.2022.
//

import SwiftUI
import AVKit
import AVFoundation

class Downloader: ObservableObject {
    
    @Published var isPopup = false
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
