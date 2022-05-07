//
//  Image.swift
//  Tik-Tok Lite
//
//  Created by Fantom on 07.04.2022.
//

import SwiftUI

extension Image {
    func circleIconModifier() -> some View {
        self
            .resizable()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .shadow(color: Color.white, radius: 2)
            .padding(.top, 60)
            .padding(.bottom, 20)
    }
    
    func iconModifier(width: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width)
    }
}

extension UIImage {
    func save(to filename: String, directory: Directory) {
        guard let imageData = self.jpegData(compressionQuality: 0.4) else {
            print("Unable to save data")
            return
        }
        
        let url = Constant.getURL(for: directory).appendingPathComponent("\(filename)")
        
        do {
            try imageData.write(to: url)
            print("Save image")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func load(filename: String, directory: Directory) -> UIImage? {
        let url = Constant.getURL(for: directory).appendingPathComponent("\(filename).jpg")
        if let imageData = try? Data(contentsOf: url) {
            return UIImage(data: imageData)
        } else {
            return nil
        }
    }
    
    static func remove(filename: String, directory: Directory) {
        let url = Constant.getURL(for: directory).appendingPathComponent("\(filename)")
        try? FileManager.default.removeItem(at: url)
    }
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
