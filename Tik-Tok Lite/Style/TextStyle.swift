//
//  TextStyle.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 11/1/21.
//
import SwiftUI
import Foundation
// MARK: - Texts style

struct MainTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular, design: .default))
            .foregroundColor(Color.white)
            //.frame(width: 275, height: 63, alignment: .center)
            //.multilineTextAlignment(.center)
           // .padding(.bottom, 20)
    }
}
extension View {
    var mainTextStyle: some View {
        self.modifier(MainTextStyle())
    }
}



struct NavigationTitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 18).bold())
            .foregroundColor(Color.white)
          //  .multilineTextAlignment(.center)
          //  .padding(.bottom, 5)
        
    }
}

extension View {
    var navigationTitleTextStyle: some View {
        self.modifier(NavigationTitleTextStyle())
    }
}


struct SettingsTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 18))
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
            .padding(.bottom, 5)
        
    }
}

extension View {
    var settingsTextStyle: some View {
        self.modifier(SettingsTextStyle())
    }
}



// MARK: - Montserrat16 Texts style

struct Montserrat16TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Montserrat", size: 16))
            .foregroundColor(.white)
    }
}
extension View {
    var montserrat16TextStyle: some View {
        self.modifier(Montserrat16TextStyle())
    }
}

// MARK: - Montserrat12 Texts style

struct Montserrat12TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Montserrat", size: 12))
            .foregroundColor(.white)
    }
}
extension View {
    var montserrat12TextStyle: some View {
        self.modifier(Montserrat12TextStyle())
    }
}
