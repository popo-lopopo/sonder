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
    @State private var offset = CGSize.zero // for back swipe
        
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
                            VStack (alignment: .leading) {
                                // desc of the selected issue
                                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean commodo ultricies lacinia. Vivamus eu aliquam felis. Morbi at rutrum arcu. Fusce nulla dolor, congue at orci nec, aliquet congue purus. ")
                                    .font(.caption)
                                Spacer()
                                // learn more button
                                Text("Learn More")
                                    .font(.caption)
                                    .padding(2.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 1)
                                    )
                            }
                            .padding(.leading, UIScreen.main.bounds.size.width / 3 + 30)
                            .padding(.trailing, 30)
                            .padding(.bottom, 30)
                            .padding(.top, 10)
                            .frame(height: 200)
                            
                            // list of ideas
                            ideaList()
                        }
  
                    }
                    .offset(x: issueId == 0 ? UIScreen.main.bounds.size.width : 0)
                    .animation(.timingCurve(0.14, 1, 0.34, 1, duration: issueId == 0 ? 0.3 : 0.6))
                    
                    // add idea floating button
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .fill(Color(UIColor.systemBlue))
                                    .frame(width: 56, height: 56)
                                    .shadow(color: .gray, radius: 6, x: 3, y: 6)
                                HStack (alignment: .bottom) {
                                    Image(systemName: "lightbulb.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 24)
                                        .foregroundColor(Color(UIColor.systemBackground))
                                        .offset(x: 4)
                                    Image(systemName: "plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 10)
                                        .foregroundColor(Color(UIColor.systemBackground))
                                        .offset(x: -4)
                                }
                            }
                        .padding()
                        }
                    }
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
                                //
                                Text("Menu")
                            }
                            .background(Color(UIColor.systemGray6))
                        }
                    )
                    : AnyView(Text(""))
                )
            } // end of navigationview
                .accentColor(Color(UIColor.systemBlue))

    } // end of body
    
}


//// preview stuff
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
