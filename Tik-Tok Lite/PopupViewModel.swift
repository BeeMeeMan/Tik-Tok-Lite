//
//  PopupViewModel.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 18.01.2022.
//

import SwiftUI

struct PopupViewModel {
    
    let image: String
    let numberText: String
    let instructionText: String
    let imageOffsetX: CGFloat
    let imageScale: CGFloat
    let scale = UIScreen.main.bounds.width
}


extension PopupViewModel{
static let promotion = [
    PopupViewModel(image: "promoStar", numberText: "Rate the app", instructionText: "Rate the app 5 stars and write a review in the AppStore", imageOffsetX: 20, imageScale: 0.7),
    PopupViewModel(image: "promoPhone", numberText: "Take a screenshot", instructionText: "Take a screenshot of the rating screen", imageOffsetX: 20, imageScale: 1),
    PopupViewModel(image: "promoLetter", numberText: "Send us a screenshot", instructionText: "In response, we will send you a promotional code that can be activated in Settings", imageOffsetX: 20, imageScale: 0.3),
        
    ]
    
}

extension PopupViewModel{
static let intro = [
    PopupViewModel(image: "IntroPhone1", numberText: "Step #1", instructionText: "In the Tik-Tok application, click “Share” button on the video you like", imageOffsetX: 20, imageScale: 0.3),
    PopupViewModel(image: "IntroPhone2", numberText: "Step #2", instructionText: "In the drop-down menu - click the \"Link\" button", imageOffsetX: 20, imageScale: 0.1),
    PopupViewModel(image: "IntroPhone3", numberText: "Step #3", instructionText: "Return to our application and click \"Download Clip\"", imageOffsetX: 20, imageScale: 0.3),
    
]

}
