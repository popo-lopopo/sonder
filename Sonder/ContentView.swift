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
        Group {
            if issueId != 0  {
                Button("Congrats! Issue id is \(issueId)") {
                    print("wow")
                }
            } else {
                IssueMenu(issueId: $issueId)
            }
        }
    } // end of body
    
}


//// preview stuff
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
