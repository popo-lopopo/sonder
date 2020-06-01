//
//  ContentView.swift
//  Sonder
//
//  Created by Paul Mielle on 21/05/2020.
//  Copyright © 2020 Paul Mielle. All rights reserved.
//

import SwiftUI
import SpriteKit


// displayed struct
struct ContentView: View {
    
    // id of the issue to display
    // if unset, display issue Graph
    @State var issueId = 0
        
    // main
    var body: some View {
        NavigationView {
            
            ZStack {
                
                // main menu
                IssueMenu(issueId: $issueId)
                // above it:
                // - a vertical stack                   (top -> bottom
                //          \_ an horizontal stack      (left -> right)
                VStack {
                    Spacer()
                        .frame(height: 200)
                    NavigationView {
                        Text("content of \(issueId)")
                        .animation(nil)
                    }
                    .offset(y: issueId == 0 ? 1000 : 0) // out of the way when the issue menu is displayed
                    .animation(.timingCurve(0.14, 1, 0.34, 1, duration: 0.6))
                }
                
            } // end of zstack
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: issueId != 0 ?
                AnyView(
                    Button(action: {
                        self.issueId = 0
                    }) {
                        HStack(spacing: 10){
                            Image(systemName: "arrow.left")
                            Text("Menu")
                        }
                    }
                )
                : AnyView(Text(""))
            )
        }
    } // end of body
    
}


//// preview stuff
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
