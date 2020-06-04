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
                                Text("View all ideas")
                                    .font(.subheadline)
                                    .padding(2.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 1)
                                    )
                                Image(systemName: "chevron.down")
                            }.onTapGesture {
                                self.issueId = 666
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
                            
                            
//                            // top border
//                            Rectangle()
//                                .fill(Color(UIColor.systemBlue))
//                                .frame(width: UIScreen.main.bounds.size.width, height: 0.2, alignment: .center)
                            // list of ideas
                            ideaList()
                        }
                        
                        
                        // swipe back handler
                        GeometryReader { geometry in
                            HStack {
                                Color.white
                                .frame(
                                    width: 30,
                                    height: UIScreen.main.bounds.size.height - geometry.safeAreaInsets.top - geometry.safeAreaInsets.bottom
                                )
                                .offset(x: self.offset.width, y: 0)
                                    .opacity(0.0001)
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            self.offset = gesture.translation
                                        }
                                        .onEnded { _ in
                                            if abs(self.offset.width) > 20 {
                                                self.issueId = 0
                                            }
                                            self.offset = .zero
                                        }
                                )
                                Spacer()
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
                                //
                                Text("Menu")
                            }
                            

                            
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                                .frame(height: 23)
                            
//                            HStack(spacing: 10){
//                                Image(systemName: "chevron.left")
//                                Text("Menu")
//                            }
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
