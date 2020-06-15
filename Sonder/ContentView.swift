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
                    
                    // main background
                    Color(UIColor.systemGray6)
                    .edgesIgnoringSafeArea(.all)
                    
                    // main menu
                    IssueMenu(issueId: $issueId)
                    if (issueId == 0) {
                        VStack {
                            Image("logo")
                            Text("Sonder")
                                .font(.headline)
                            Spacer()
                            VStack {
                                Text("What is this place?")
                                    .font(.subheadline)
                                    .padding(2.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 1)
                                    )
                                Image(systemName: "chevron.down")
                            }
                            
                        }
                    }
                    
                    
                    // detail of the selected issue
                    ZStack {
                        
                        VStack (alignment: .leading, spacing: 0) {
                            // right text lext to the icon
                            // desc of the selected issue
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean commodo ultricies lacinia. Vivamus eu aliquam felis. Morbi at rutrum arcu. Fusce nulla dolor, congue at orci nec. ")
                                .font(.caption)
                                .padding(.leading, UIScreen.main.bounds.size.width / 3 + 30)
                                .padding(.trailing, 30)
                            
                            // main issue title
                            HStack (spacing: 0) {
                                Text("A pretty long issue title for \(self.issueId)")
                                    .font(.largeTitle).fontWeight(.bold)
                                    .padding()
                                
                                Spacer()
                            }
                            .foregroundColor(Color(UIColor.systemBackground))
                            .background(Color(UIColor(named: "colors/\(self.issueId)") ?? .gray))
                            .offset(y: 40)
                            
                            
                            // list of ideas
                            ideaList()
                            .zIndex(-1)
                        }
                        
                        // add idea floating button
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                ZStack {
                                    Circle()
                                        .fill(Color(UIColor(named: "colors/\(self.issueId)") ?? .gray))
                                        .frame(width: 60, height: 60)
                                        //.shadow(color: .black, radius: 6, x: 3, y: 6)
                                    HStack (alignment: .bottom) {
                                        Image(systemName: "lightbulb.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 24)
                                            .foregroundColor(Color(UIColor.white))
                                            .offset(x: 4)
                                        Image(systemName: "plus")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 10)
                                            .foregroundColor(Color(UIColor.white))
                                            .offset(x: -4)
                                    }
                                }
                            .padding()
                            }
                        }
  
                    }
                    .offset(x: issueId == 0 ? UIScreen.main.bounds.size.width : 0)
                    .animation(.timingCurve(0.14, 1, 0.34, 1, duration: issueId == 0 ? 0.3 : 0.6))
                    
                }
                .navigationBarColor(.clear) // requires cleanStatusBar.swift
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: issueId != 0 ?
                    AnyView(
                        Button(action: {
                            self.issueId = 0
                        }) {
                            HStack {
                                // matches the style of the back button of child views
                                Image(systemName: "chevron.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                    .frame(height:21)
                                    .offset(x: -7)
                                .font(Font.title.weight(.medium))
                                // back button
                                Text("Menu")
                            }
                            .foregroundColor(Color(UIColor(named: "colors/\(self.issueId)") ?? .gray))
                            .background(Color(UIColor.systemGray6))
                        }
                    )
                    : AnyView(Text(""))
                )
            } // end of navigationview
                .accentColor(Color(UIColor(named: "colors/\(self.issueId)") ?? .gray))

    } // end of body
    
}


//// preview stuff
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
