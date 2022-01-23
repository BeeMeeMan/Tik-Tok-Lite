//
//  PlaylistData.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 18.01.2022.
//

import SwiftUI

struct PlaylistData: Codable, Hashable{
    
    var name: String = ""
    var description: String? = ""
    var videoArr: [String] = []
    var playlistData: [String: String] = [:]

    
    // var image: Image? = Image("CirclePhoto")
}

func savePlaylistArray(_ array: [PlaylistData]){
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(array) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: "plistArr")
    }
}
