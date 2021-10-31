//
//  DownloadView.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 10/29/21.
//

import SwiftUI

struct DownloadView: View {
    
    @State private var showingPromo = false
    
    
    var body: some View {
        ZStack{
            Color.black
            VStack{
                
                HStack{
                    Text("Instruction")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        showingPromo = true
                    }){
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.roseColor, lineWidth: 1)
                                .frame(width: 181, height: 35)
                               // .blendMode(.destinationOut)
                                .blur(radius: 1 )
                            HStack{
                            Image("Discount")
                            Text("Month free")
                              .foregroundColor(Color.roseColor)
                            }
                        }
                    }
                    
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
                Button(action: {
                    
                    
                })  {
                    HStack{
                        Image(systemName: "arrow.down.doc.fill")
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(.white)
                        Text("Download clip")
                            .font(.system(size: 16, weight: .regular, design: .default))
                        
                    }
                }
                .roseButtonStyle()
                // .buttonStyle(ActionButtonStyle())
                .padding(.bottom, 50)
            }
        }
        .fullScreenCover(isPresented: $showingPromo, content: PromotionTabView.init)
    }
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
    }
}
