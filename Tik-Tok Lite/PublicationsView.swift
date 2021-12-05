//
//  PublicationsView.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 10/29/21.
//

import SwiftUI

struct PublicationsView : View {
    var body: some View {
        
        NavigationView{
            
            
            ZStack{
                Color.black
                VStack{
                    Spacer()
                    Image("Publications")
                        .scaleEffect(2, anchor: .center)
                        .padding(.bottom, 100)
                    
                    Text("Make your first delayed publication")
                        .mainTextStyle
                        .padding(.bottom, 150)
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Image("Calendar")
                                    .foregroundColor(.roseColor))
            .navigationTitle("Delayed publications")
            .font(.system(size: 16, weight: .regular, design: .default))
            
            
        }
    }
}

//struct PublicationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PublicationsView()
//    }
//}
