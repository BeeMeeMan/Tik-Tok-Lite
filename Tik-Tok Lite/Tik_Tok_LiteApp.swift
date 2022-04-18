//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI

@main
struct Tik_Tok_LiteApp: App {
    @StateObject var downloader = Downloader()
    @StateObject var dataStorage = StorageModel()
    @StateObject var notifDelegate = NotificationDelegate()
    
    var body: some Scene {
        WindowGroup {
           SplashScreen()
                .environmentObject(downloader)
                .environmentObject(notifDelegate)
                .environmentObject(dataStorage)
                .onAppear {
                    UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
