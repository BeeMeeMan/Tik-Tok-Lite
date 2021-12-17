////
////  Tik_Tok_LiteApp.swift
////  Tik-Tok Lite
////
////  Created by Jenya Korsun on 10/31/21.
////
//
//import SwiftUI
//import AVKit
//import AVFoundation
//
//
////class HalfSheetPosition: ObservableObject {
////
////    @Published var position = CardPosition.bottom
////    @Published var opasity = 0.0
////    @Published var TikData: Array<Tiktok> = []
////
////}
//
//struct Handle : View {
//
//    @EnvironmentObject var halfSheet: HalfSheetPosition
//    @EnvironmentObject var TikData: HalfSheetPosition
//    @State private var presentAlert = false
//    @State private var player = AVPlayer(url: URL(string: "https://www.rmp-streaming.com/media/big-buck-bunny-360p.mp4")!)
//
////    init(){
////
////        player = AVPlayer(url: (halfSheet.TikData.last?.url(forFile: .video))!)
////    }
////
//    private let handleThickness = CGFloat(5.0)
//    var body: some View {
////        RoundedRectangle(cornerRadius: handleThickness / 2.0)
////            .frame(width: 40, height: handleThickness)
////           // .foregroundColor(Color.secondary)
////            .padding(5)
//        ZStack{
//            Color.barBackgroundGrey
//            VStack{
//                HStack{
//            Text("Download video")
//                        .bold()
//                        .padding(.leading, 10)
//                    Spacer()
//                }
//                .padding(.top, 10)
//       // halfSheet.TikData.last?.vImg
//                PlayerView(player: $player)
//            .padding(.top, 5)
//                Button(action: {
//                    presentAlert = true
//                    halfSheet.TikData.last?.vImg?.videoPlayer.pause()
//
//
//
//                })  {
//                    HStack{
//                        Image(systemName: "arrow.down.doc.fill")
//                            .frame(width: 20, height: 20, alignment: .center)
//                            .foregroundColor(.white)
//                        Text("Download clip")
//                            .font(.system(size: 16, weight: .regular, design: .default))
//
//                    }
//                }
//                .roseButtonStyle()
//                .padding(.top, 10)
//                .padding(.bottom, 10)
//                Button(action: {
//
//
//
//                })  {
//                    HStack{
//                        Image(systemName: "star.fill")
//                            .frame(width: 20, height: 20, alignment: .center)
//                            .foregroundColor(.white)
//                        Text("Add to playlist")
//                            .font(.system(size: 16, weight: .regular, design: .default))
//
//                    }
//                }
//                .roseButtonStyle()
//            Spacer()
//            }
//            .alert("Attention", isPresented: $presentAlert, actions: {
//
//                Button("Ok") {
//                    halfSheet.position = CardPosition.bottom
//                    halfSheet.opasity = 0.0
//                }
//                    }, message: {
//                      Text("Video saved in your gallery")
//
//
//            }) // 4
//        }
//
//    }
//}
//
//
//
//struct SlideOverCard<Content: View> : View {
//    @GestureState private var dragState = DragState.inactive
//    @EnvironmentObject var halfSheet: HalfSheetPosition
//    @Environment(\.presentationMode) var presentationMode
//
//    var content: () -> Content
//    var body: some View {
//        let drag = DragGesture()
//            .updating($dragState) { drag, state, transaction in
//                state = .dragging(translation: drag.translation)
//            }
//            .onEnded(onDragEnded)
//
//        return Group {
//            if halfSheet.position == CardPosition.top {
//                Handle()} else {
//            self.content()
//                }
//        }
//        .frame(height: UIScreen.main.bounds.height)
//        .background(Color.barBackgroundGrey)
//        .cornerRadius(10.0)
//        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
//        .offset(y: halfSheet.position.rawValue + self.dragState.translation.height)
//
//        .animation(self.dragState.isDragging ? nil : .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
//        .gesture(drag)
//    }
//
//    private func onDragEnded(drag: DragGesture.Value) {
//        let verticalDirection = drag.predictedEndLocation.y - drag.location.y
//        let cardTopEdgeLocation = halfSheet.position.rawValue + drag.translation.height
//        let positionAbove: CardPosition
//        let positionBelow: CardPosition
//        let closestPosition: CardPosition
//
//        if cardTopEdgeLocation <= CardPosition.middle.rawValue {
//            positionAbove = .top
//            positionBelow = .bottom
//            //positionBelow = .middle
//        } else {
//            positionAbove = .top
//            positionBelow = .bottom
//            //positionAbove = .middle
//
//        }
//
//        if (cardTopEdgeLocation - positionAbove.rawValue) < (positionBelow.rawValue - cardTopEdgeLocation) {
//            closestPosition = positionAbove
//        } else {
//            closestPosition = positionBelow
//        }
//
//        if verticalDirection > 0 {
//            halfSheet.position = positionBelow
//        } else if verticalDirection < 0 {
//            halfSheet.position = positionAbove
//        } else {
//            halfSheet.position = closestPosition
//        }
//
//        // Closing halfSheet
//        if halfSheet.position == CardPosition.bottom ||  halfSheet.position == closestPosition{
//            halfSheet.opasity = 0.0
//            presentationMode.wrappedValue.dismiss()
//        }
//    }
//}
//
//enum CardPosition: CGFloat {
//
//    case top = 50
//    case middle = 500
//    case bottom = 2000
//}
//
//enum DragState {
//    case inactive
//    case dragging(translation: CGSize)
//
//    var translation: CGSize {
//        switch self {
//        case .inactive:
//            return .zero
//        case .dragging(let translation):
//            return translation
//        }
//    }
//
//    var isDragging: Bool {
//        switch self {
//        case .inactive:
//            return false
//        case .dragging:
//            return true
//        }
//    }
//}
//
