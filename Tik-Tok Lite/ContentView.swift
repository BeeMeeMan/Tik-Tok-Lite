//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//

import SwiftUI
import AVKit


//  MARK: - For ModalView -------------------------------------------------
struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

extension UIViewController {
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, transitionStyle: UIModalTransitionStyle = .coverVertical, @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        self.present(toPresent, animated: true, completion: nil)
    }
}

///-------------------------------------------------

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
                
                DownloadView(showDownloadPopUpView: $showDownloadPopUpView)

                    .tabItem {
                        
                        Image(systemName: "arrow.down.doc")
                        Text("Download")
                        
                    }
                    .tag(Tabs.One)
                
                PlayListsView(showDownloadFromPlaylistPopUpView: $showDownloadFromPlaylistPopUpView)
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




