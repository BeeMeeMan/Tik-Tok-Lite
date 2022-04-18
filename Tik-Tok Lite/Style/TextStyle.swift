
import SwiftUI

// MARK: - Texts style

struct MainTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular, design: .default))
            .foregroundColor(Color.white)
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


//////
///

extension View {
    func helvetica18TextStyle(color: Color) -> some View {
        self.modifier(Helvetica18TextStyle(color: color))
    }
}

struct Helvetica18TextStyle: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica", size: 18).weight(.regular))
            .foregroundColor(color)
    }
}
    
