//
//  Downloade.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 11.04.2022.
//

import SwiftUI

struct Welcome1: Codable {
    let id: String
    let createTime: String
    let desc: String
    let video: Video
    
    struct Video: Codable {
        let playAddr: String
        let downloadAddr: String
        let cover: String
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
