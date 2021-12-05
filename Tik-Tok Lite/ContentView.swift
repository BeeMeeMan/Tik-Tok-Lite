//
//  ContentView.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 10/26/21.
//

import SwiftUI
extension UIScreen{
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let size = UIScreen.main.bounds.size
}

// Colors
enum Tabs: String {
    case One
    case Two
    case three
    case four
}


struct ContentView: View {
    //   let screen = CustomNavigationView()
    //    var body: some View {
    //       screen
    //    }
    
    
    init() {
        
        let appearance = UINavigationBarAppearance()
        
        // appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.18, green: 0.176, blue: 0.176, alpha: 1)
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        
        UITabBar.appearance().backgroundColor = UIColor(red: 0.18, green: 0.176, blue: 0.176, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        
        
    }
    
    
    @State private var showingDetail = false
    
    @State private var selectedTab: Tabs = .One
    
    // @State private var tabName = "Download"
    
    var body: some View {
        
        
        ZStack {
            
            
            
            //   NavigationView {
            TabView(selection: $selectedTab) {
                
                DownloadView()
                
                    .tabItem {
                        
                        Image(systemName: "arrow.down.doc")
                        Text("Download")
                        
                    }
                
                
                    .tag(Tabs.One)
                
                PlayListsView()
                    .tabItem {
                        Image(systemName: "star")
                        Text("Playlists")
                        
                    }
                    .tag(Tabs.Two)
                
                PublicationsView()
                    .tabItem {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("Publications")
                    }
                    .tag(Tabs.three)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                
                    .tag(Tabs.four)
            }
            
            
            .accentColor(.roseColor)
            
            //                    .onAppear() {
            //
            //                    }
            
            
            
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(
                        titleText()
                        
                    )
                        .navigationTitleTextStyle
                    
                }
                
                
            }
            .ignoresSafeArea()
            
            
            
            //      TEST PROMOTION TAB VIEW
            //            Button("Show Detail") {
            //
            //                showingDetail = true
            //
            //             }
            
            .fullScreenCover(isPresented: $showingDetail, content: IntroTabView.init)
          
        }
        .preferredColorScheme(.dark) // white tint on status bar
        
        
        
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
    
    
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

