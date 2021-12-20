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
  func grayButtonStyle() -> some View {
      buttonStyle(ActionGrayButtonStyle())
  }
}

extension View {
  func closeButtonStyle() -> some View {
      buttonStyle(CloseButtonStyle())
  }
}


struct ActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: UIScreen.width * 0.92, height: 53, alignment: .center)
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


struct ActionGrayButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: UIScreen.width * 0.92, height: 53, alignment: .center)
            .foregroundColor(.white)
           // .font(Font.body.bold())
          //  .padding(10)
           // .padding(.horizontal, 20)
            .background(barBackgroundGrey.opacity(
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



