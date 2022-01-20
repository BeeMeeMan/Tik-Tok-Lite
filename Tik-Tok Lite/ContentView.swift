//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI
import AVKit


extension UIScreen{
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let size = UIScreen.main.bounds.size
}

struct ContentView: View {
    
    init() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 0.18, green: 0.176, blue: 0.176, alpha: 1)
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().backgroundColor = UIColor(red: 0.18, green: 0.176, blue: 0.176, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        
    }
    
    // Test new modalPopUp:
    @State private var showModal = false
    @State private var showingDetail = false
    @State private var selectedTab: Tabs = .One
    
    @State private var showDownloadPopUpView = false
    @State private var showDownloadFromPlaylistPopUpView = false
    
    @EnvironmentObject var downloader: Downloader
    
    enum Tabs: String {
        case One
        case Two
        case three
        case four
    }
    
    var body: some View {
        
        ZStack {
            
            TabView(selection: $selectedTab) {
                
                DownloadTabView(showDownloadPopUpView: $showDownloadPopUpView)

                    .tabItem {
                        
                        Image(systemName: "arrow.down.doc")
                        Text("Download")
                        
                    }
                    .tag(Tabs.One)
                
                PlaylistsTabView(showDownloadFromPlaylistPopUpView: $showDownloadFromPlaylistPopUpView)
                    .tabItem {
                        
                        Image(systemName: "star")
                        Text("Playlists")
                        
                    }
                    .tag(Tabs.Two)
                
                PublicationsTabView()
                    .tabItem {
                        
                        Image(systemName: "clock.arrow.circlepath")
                        Text("Publications")
                        
                    }
                    .tag(Tabs.three)
                
                SettingsTabView()
                    .tabItem {
                        
                        Image(systemName: "gear")
                        Text("Settings")
                        
                    }
                
                    .tag(Tabs.four)
            }
            .accentColor(.roseColor)

           
            
                      
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                
                Text(titleText())
                 .navigationTitleTextStyle
                
            }
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showingDetail){ PopupView(viewData: PopupViewModel.intro)}
        .preferredColorScheme(.dark) // white tint on status bar
        .onAppear(){
            if !isAppAlreadyLaunchedOnce(){
                showingDetail = true
            }
        }
    }
    

    
    func titleText() -> String{
        
        switch selectedTab {
            
        case .One:
            return "Download video"
        case .Two:
            return "Playlists"
        case .three:
            return "Deferred posts"
        case .four:
            return "Settings"
            
        }
        
    }
    
    
    
    func isAppAlreadyLaunchedOnce()->Bool{
            let defaults = UserDefaults.standard
            
            if defaults.bool(forKey: "isAppAlreadyLaunchedOnce"){
                print("App already launched : \(isAppAlreadyLaunchedOnce)")
                return true
            }else{
                defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
                print("App launched first time")
                return false
            }
        }
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




