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
    
   
    @Published var isActiveDownload = false
    @Published var isActivePlayer = false
    @Published var TikDataTemp: Array<Tiktok> = []
    @Published var TikData: Array<Tiktok> = []
    @Published var plistArr: Array<PlaylistData> = []
    
    
    init(){
        let defaults = UserDefaults.standard
        if let plistArr = defaults.object(forKey: "plistArr") as? Data {
            let decoder = JSONDecoder()
            if let loadedPlistArr = try? decoder.decode(Array<PlaylistData>.self, from: plistArr) {
                self.plistArr = loadedPlistArr
            }
        }
        
    }
}
