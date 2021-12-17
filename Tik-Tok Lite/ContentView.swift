//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI

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
   
//    @EnvironmentObject var halfSheet: HalfSheetPosition
//    @EnvironmentObject var TikData: HalfSheetPosition
    
    // Tabs pages enum
    enum Tabs: String {
        case One
        case Two
        case three
        case four
    }
    
    var body: some View {
        
        ZStack {
            
            TabView(selection: $selectedTab) {
                
                DownloadView()
//                Button(action: {
//                    withAnimation(.easeInOut){
//                        showModalView.isPresented = true
//
//                    }
//
//                }){
//                        Text("Click me")
//                }
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
        //    blackScreenCover
//            SlideOverCard() {
//                ZStack{
//                    VStack {
//                        HStack{
//                            Spacer()
//                            ProgressView()
//                                .scaleEffect(1.5)
//                            Spacer()
//                        }
//                        .padding(.top, UIScreen.height * 0.2)
//                        .padding(.bottom, 10)
//                        Text("Clip is downloading")
//                        Spacer()
//
//                    }
//
//                }
//
//            }
            
            
            ModalView()
                      
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                
                Text(titleText())
                 .navigationTitleTextStyle
                
            }
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showingDetail, content: IntroTabView.init)
        .preferredColorScheme(.dark) // white tint on status bar
         
    }
    
//MARK: blackScreenCover effect
//    var blackScreenCover: some View {
//
//        Color.black
//            .opacity(halfSheet.opasity)
//            .onTapGesture {
//                halfSheet.position = CardPosition.bottom
//                halfSheet.opasity = 0.0
//            }
//
//    }
    
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

