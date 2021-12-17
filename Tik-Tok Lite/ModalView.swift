//
//  ModalView.swift
//  CustomModalPopup
//
//  Created by Fantom on 15.12.2021.
//

import SwiftUI

class ShowModalView: ObservableObject {
    
    @Published var position = ModalViewPosition.Close
    @Published var TikData: Array<Tiktok> = []
    
}

enum ModalViewPosition{
    
    case Download
    case Player
    case Close
}

struct ModalView: View {
    
    @EnvironmentObject var showModalView: ShowModalView
    @State private var isDragging = false
    @State private var curHeight: CGFloat = 400
    
    let minHeight: CGFloat = 400
    let maxHeight: CGFloat = 800
    
    let startOpacity = 0.4
    let endOpacity = 0.8
    
    var dragPercentage: Double {
        
        let res = Double((curHeight - minHeight) / (maxHeight - minHeight))
        
        return max(0, min(1, res))
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            
            if showModalView.position != ModalViewPosition.Close{
                
            Color.black
                .opacity(startOpacity + (endOpacity - startOpacity) * dragPercentage)
                .ignoresSafeArea()
                .onTapGesture {
                    
                    withAnimation(.easeInOut) {
                        
                        showModalView.position = ModalViewPosition.Close
                        
                    }
                }
                if showModalView.position == ModalViewPosition.Download{
                    downloadView
            .transition(.move(edge: .bottom))
                }
//                if showModalView.position == ModalViewPosition.Player{
//
//                    playerView
//                        .onAppear(){
//                            curHeight = maxHeight
//                        }
//                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
      //  .animation(.easeIn(duration: 2))
        
    
        .popover(isPresented: $isDragging) {
                    Text("Your content here")
                        .font(.headline)
                        .padding()
        }
    }
            
// MARK: - playerView
    
    var playerView: some View{
        
        VStack{
            // Handle
            
            ZStack{
                Capsule()
                    .foregroundColor(Color.lightGray)
                    .frame(width: 40, height:  6)
              
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.000001))  // important for the dragging
            .gesture(dragGesture)
            
            ZStack{
               // Color.barBackgroundGrey
                Color.green
                  
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        ProgressView()
                            .scaleEffect(1.5)
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    Text("Clip is playing")
                    Spacer()
                    
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
            
           
        }
        .frame(height: curHeight)
        .frame(maxWidth:.infinity)
        .background(
        //Hack for corderRadius only on top
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.barBackgroundGrey)
                Rectangle()
                    .frame(height: curHeight / 2)
            }
                .foregroundColor(Color.white)
        )
       // .animation(isDragging ? nil : .easeInOut(duration: 0.45))
        
        .onDisappear {
            
            curHeight = minHeight
        }
    }

    
// MARK: - downloadView
    
    var downloadView: some View{
        
        VStack{
            // Handle
            
            ZStack{
                Capsule()
                    .foregroundColor(Color.lightGray)
                    .frame(width: 40, height:  6)
              
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.000001))  // important for the dragging
            .gesture(dragGesture)
            
            ZStack{
                Color.barBackgroundGrey
                  
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        ProgressView()
                            .scaleEffect(1.5)
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    Text("Clip is downloading")
                    Spacer()
                    
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
            
           
        }
        .frame(height: curHeight)
        .frame(maxWidth:.infinity)
        .background(
        //Hack for corderRadius only on top
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.barBackgroundGrey)
                Rectangle()
                    .frame(height: curHeight / 2)
            }
                .foregroundColor(Color.white)
        )
       // .animation(isDragging ? nil : .easeInOut(duration: 0.45))
        .onDisappear {
            
            curHeight = minHeight
        }
    }
        @State private var prevDragTranslation = CGSize.zero
        
        var dragGesture: some Gesture{
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged { val in
                    
                    if !isDragging{
                        isDragging = true
                    }
                    let dragAmount = val.translation.height - prevDragTranslation.height
                    
                    if curHeight > maxHeight || curHeight < minHeight{
                        curHeight -= dragAmount / 6
                    } else {
                        curHeight -= dragAmount
                    }
                   
                    prevDragTranslation = val.translation
                }
                .onEnded { val in
                    withAnimation(.easeInOut(duration: 0.4)) {
                    prevDragTranslation = .zero
                    isDragging = false
                    if curHeight > maxHeight {
                        curHeight = maxHeight
                    }
                    if curHeight < minHeight {
                        curHeight = minHeight
                    }
                    }
                }
            
            
        }
    
}



struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
