//
//  NavigationBarShape.swift
//  Tik-Tok Lite
//
//  Created by user206820 on 10/29/21.
//
//import SwiftUI
//import Foundation
//
//struct WaveShape : Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        path.move(to: .zero)
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
//                      control1: CGPoint(x: rect.maxX * 0.75, y: rect.maxY * 0.5),
//                      control2: CGPoint(x: rect.maxX * 0.35, y: rect.maxY * 2))
//        return path
//    }
//}
