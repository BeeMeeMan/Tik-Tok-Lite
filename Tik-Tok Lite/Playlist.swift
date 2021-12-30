//
//  Playlist.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 21.12.2021.
//

import SwiftUI

struct Playlist: Codable, Hashable{
    
    var name: String = ""
    var description: String? = ""
    var videoArr: [String] = []
   // var image: Image? = Image("CirclePhoto")

}

func savePlaylistArray(_ array: [Playlist]){
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(array) {
        let defaults = UserDefaults.standard
        defaults.set(encoded, forKey: "plistArr")
    }
}
