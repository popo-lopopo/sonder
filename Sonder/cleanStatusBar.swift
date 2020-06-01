//
//  cleanStatusBar.swift
//  Sonder
//
//  Created by Paul Mielle on 01/06/2020.
//  Copyright © 2020 Paul Mielle. All rights reserved.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
        
    var backgroundColor: UIColor?
    //@Environment(\.colorScheme) var colorScheme: ColorScheme
    
    init( backgroundColor: UIColor?) {
        
        
        //let fgcolor = colorScheme == .dark ? UIColor.white : UIColor.black
        //let fgcolor = UIColor.systemBlue
        
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        //coloredAppearance.titleTextAttributes = [.foregroundColor: fgcolor]
        //coloredAppearance.largeTitleTextAttributes = [.foregroundColor: fgcolor]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        //UINavigationBar.appearance().tintColor = fgcolor

    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
 
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }

}
