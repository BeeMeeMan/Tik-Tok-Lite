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
    // @StateObject var halfSheet = HalfSheetPosition()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(downloader)
                .onAppear {
                    UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
