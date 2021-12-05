//
//  PublicationsView.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 10/29/21.
//

import SwiftUI

struct SettingsView : View {
    
    
    
    let backItem = BackItem()
    
    var menuButtons = [
        SettingsButtonView(buttonImage: "SettingsBarImage1", buttonText: "Whrite us"),
        SettingsButtonView(buttonImage: "SettingsBarImage2", buttonText: "Subscriptions"),
        SettingsButtonView(buttonImage: "SettingsBarImage3", buttonText: "Rate the app"),
        SettingsButtonView(buttonImage: "SettingsBarImage4", buttonText: "Share the app"),
        SettingsButtonView(buttonImage: "SettingsBarImage5", buttonText: "Promo code"),
    ]
    
    
    
    
    var body: some View {
        
            
            NavigationView {
                ZStack{
                    Color.black
                VStack{
                    VStack { /// 2.
                        ///
                        
                        ForEach(menuButtons, id: \.self) { menu in
                            
                            NavigationLink(
                                
                                destination:  Group {
                                    
                                    if menu.buttonText == "Whrite us" {
                                        
                                        PromocodeView()
                                            .frame(width: 200, height: 200, alignment: .center)
                                        
                                    }
                                    
                                    if menu.buttonText == "Subscriptions" {
                                        AboutUs()
                                    }
                                    
                                    if menu.buttonText == "Promo code" {
                                        PromocodeView()
                                    }
                                    
                                } ){
                                    
                                    SettingsButtonView(buttonImage: menu.buttonImage, buttonText: menu.buttonText)
                                }
                            
                        }
                        .padding(.bottom, 10)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Settings")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        
                        
                    }
                    .padding(.top, 5)
                    .padding(15)
                    .background(Color(UIColor(red: 0.18, green: 0.176, blue: 0.176, alpha: 1)))
                    .cornerRadius(15)
                    .padding(.top, 20)
                    
                    Spacer()
                }
            }
        }
    }
}


struct BackItem: View {
    
    var body: some View {
        
        Text("All work fine")
    }
    //       SettingsView.bringSubviewToFront(Profile)
    
    
    
}


struct AboutUs: View {
    
    var body: some View {
        Text("Hellow there")
    }
}


