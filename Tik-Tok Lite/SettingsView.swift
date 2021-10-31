//
//  PublicationsView.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 10/29/21.
//

import SwiftUI

struct SettingsView : View {
    var body: some View {
        ZStack{
            Color.black
        
            Image("Settings")
            .scaleEffect(2, anchor: .center)
            
            Text("Something")
                    .mainTextStyle
                    .padding(.top, 50)
        }
    }
}

//struct PublicationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PublicationsView()
//    }
//}
