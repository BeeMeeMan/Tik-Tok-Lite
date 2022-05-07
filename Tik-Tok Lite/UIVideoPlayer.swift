//
//  CustomVideoPlayer.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 18.01.2022.
//

import SwiftUI
import UIKit
import AVKit

struct UIVideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer
    
    class Coordinator: NSObject {
        var parent: UIVideoPlayer
        
        init(parent: UIVideoPlayer) {
            self.parent = parent
        }
        
        @objc func restartPlayback() {
            parent.player.seek(to: .zero)
        }
    }
  
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspect
        player.actionAtItemEnd = .none
        
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayback), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        return controller
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func updateUIViewController(_ uiView: AVPlayerViewController, context: Context) { }
}
