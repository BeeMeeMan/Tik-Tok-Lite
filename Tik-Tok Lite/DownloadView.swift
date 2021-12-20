//
//  Tik_Tok_LiteApp.swift
//  Tik-Tok Lite
//
//  Created by Jenya Korsun on 10/31/21.
//


import SwiftUI
import AVKit
import AVFoundation

var size: CGFloat = 160
let baseDocUrl = try! FileManager.default.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)


struct DownloadView: View {
    
    @EnvironmentObject var showModalView: ShowModalView
    @State private var showingPromoView = false
    @State var showingInfoView = false
    @State var update = false
    @StateObject var notifDelegate = NotificationDelegate()
//    @EnvironmentObject var halfSheet: HalfSheetPosition
//    @EnvironmentObject var TikData: HalfSheetPosition
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
                
                Color.black
                
                VStack{
                    
                    HStack{
                        
                        Text("Instruction")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        Spacer()
                        
                        showingPromoViewButton
                    }
                    .padding(16)
                    
                    Spacer()
                    Spacer()
                    Spacer()
    
                    Image("Download")
                        .scaleEffect(1.6, anchor: .center)
                    
                    Text("Download clip")
                        .mainTextStyle
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    downloadClipButton
                    
                }
                
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: showingInfoViewButton)
                .navigationTitle("Download clip")
                .font(.system(size: 16, weight: .regular, design: .default))
                
            }
            
            //.fullScreenCover(isPresented: $showingPromoView, content: TestPopUp.init)
            .fullScreenCover(isPresented: $showingPromoView) {
                PromotionTabView()
                   }
            .fullScreenCover(isPresented: $showingInfoView, content: IntroTabView.init)
            
        }
    }
    
    
    //MARK: showingInfoViewButton
    
    var showingInfoViewButton: some View {
        
        Button(action:{
            
            showingInfoView = true
            
        }){
            
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundColor(.roseColor)
            
        }
    }
    
    
    //MARK: showingPromoViewButton
    
    var showingPromoViewButton: some View{
        
        Button(action: {
            showingPromoView = true
        }){
            
            ZStack{
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.roseColor, lineWidth: 1)
                    .frame(width: 181, height: 35)
                    .blur(radius: 1 )
                HStack{
                    Image("Discount")
                    Text("Month free")
                        .foregroundColor(Color.roseColor)
                }
            }
        }
        
    }
    
    //MARK: downloadClipButton
    
    var downloadClipButton: some View {
        
        Button(action: {
            showModalView.isActiveDownload = true
            
        }){
            HStack{
                Image(systemName: "arrow.down.doc.fill")
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(.white)
                Text("Download clip")
                    .font(.system(size: 16, weight: .regular, design: .default))
                
            }
        }
        .roseButtonStyle()
        
        .padding(.bottom, 50)
        
    }
    
    
}



