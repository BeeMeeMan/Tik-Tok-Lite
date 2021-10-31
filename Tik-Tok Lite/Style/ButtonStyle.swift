//
//  ButtonStyle.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 10/26/21.
//

import SwiftUI

extension View {
  func roseButtonStyle() -> some View {
      buttonStyle(ActionButtonStyle())
  }
}

extension View {
  func closeButtonStyle() -> some View {
      buttonStyle(CloseButtonStyle())
  }
}

struct MainTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular, design: .default))
            .foregroundColor(Color.white)
            .frame(width: 275, height: 63, alignment: .center)
            .multilineTextAlignment(.center)
            .padding(.bottom, 20)
    }
}
extension View {
    var mainTextStyle: some View {
        self.modifier(MainTextStyle())
    }
}




struct ActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 343, height: 53, alignment: .center)
            .foregroundColor(.white)
           // .font(Font.body.bold())
          //  .padding(10)
           // .padding(.horizontal, 20)
            .background(roseColor.opacity(
                configuration.isPressed ? 0.5 : 1
            ))
            .cornerRadius(10)
    }
}

struct CloseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
          .opacity(
                configuration.isPressed ? 0.5 : 1
            )
            
    }
}


