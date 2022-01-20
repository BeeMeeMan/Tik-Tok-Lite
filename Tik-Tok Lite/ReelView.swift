//
//  ReelView.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 18.01.2022.
//

//import SwiftUI
//import AVKit
//
//struct ReelsView: View {
//
//    @State var currentReel = ""
//
//    @State var reels = mediaFileJSON.map{ item -> Reel in
//        let url = Bundle.main.path(forResource: item.url, ofType: "mp4") ?? ""
//        let player = AVPlayer(url: URL(fileURLWithPath: url))
//        return Reel(player: player, mediaFile: item)
//    }
//
//    var body: some View {
//
//        GeometryReader{ proxy in
//
//            let size = proxy.size
//
//            TabView(selection: $currentReel) {
//                ForEach($reels){ $reel in
//                    ReelsPlayerView(reel: $reel, currentReel: $currentReel)
//                        .frame(width: size.width)
//                        .padding()
//                        .rotationEffect(.degrees(-90))
//                        .ignoresSafeArea(.all, edges: .top)
//                        .tag(reel.id)
//                }
//            }
//            .rotationEffect(.degrees(90))
//            .frame(width: size.height)
//            .tabViewStyle(.page(indexDisplayMode: .never))
//            .frame(width: size.width)
//        }
//        .ignoresSafeArea(.all, edges: .top)
//        .background(.black)
//        .onAppear {
//            currentReel = reels.first?.id ?? ""
//        }
//    }
//}
//
//struct ReelsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//struct TiyktokPlayerView: View {
//
//    @Binding var player : AVPlayer
//    @Binding var currentTiktok: String
//    @State var showMore = false
//
//    var body: some View {
//
//        ZStack{
//            if let player = player{
//            CustomVideoPlayer(player: player)
//                GeometryReader{ proxy -> Color in
//
//                    let minY = proxy.frame(in: .global).minY
//                    let size = proxy.size
//
//                    DispatchQueue.main.async {
//                        if -minY < (size.height/2) && minY < (size.height/2) && currentReel == reel.id{
//                            player.play()
//                        } else {
//                            player.pause()
//                        }
//                    }
//                    return Color.clear
//
//                }
//
//              
//            }
//        }
//    }
//
//}
//
