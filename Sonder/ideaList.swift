//
//  ideaList.swift
//  Sonder
//
//  Created by Paul Mielle on 01/06/2020.
//  Copyright © 2020 Paul Mielle. All rights reserved.
//

import SwiftUI

struct ideaRow: View {
    var idea: idea
    var body: some View {
        HStack {
            Image("default_idea_thumbnail")
            
            VStack (alignment: .leading) {
                Text("\(idea.name) is a cool idea name lol on rigole ahahaaha ahah")
                    .lineLimit(2)
                    .font(.headline)
                    .padding(.top, 10)
                    .padding(.trailing, 30)
                Spacer()
                HStack {
                    VStack (alignment: .leading) {
                        Text("123 likes")
                        Text("123 comments")
                    }
                    .font(.caption)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding(.bottom, 10)
                
            }
            .padding(.leading, 10)
            
        }
    }
}

struct ideaList: View {
    var body: some View {
        // ideas of day 1
        let a1 = idea(name: "aaa")
        let b1 = idea(name: "bbb")
        let c1 = idea(name: "ccc")
        let d1 = idea(name: "ddd")
        let e1 = idea(name: "eee")
        let ideasday1 = [a1,b1,c1,d1,e1]
        
        // ideas of day 2
        let a2 = idea(name: "aaa")
        let b2 = idea(name: "bbb")
        let c2 = idea(name: "ccc")
        let d2 = idea(name: "ddd")
        let e2 = idea(name: "eee")
        let ideasday2 = [a2,b2,c2,d2,e2]
        
        let sections = [timeperiod(name: "Today", contentideas: ideasday1) ,timeperiod(name: "This Week", contentideas: ideasday2)]
        
        return ScrollView {
            
            VStack (spacing: 0) {
                ForEach (sections) {section in
                    
                    // group label
                    Text(section.name)
                        .font(.caption)
                        .foregroundColor(Color(UIColor.systemGray))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 60)
                        .padding(.bottom, 15)
                        .padding(.leading, 20)
                    
                    // idea row
                    ForEach (section.contentideas) { idea in
                        ideaRow(idea: idea)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                    }
                    
                }
            } // end of vstack
        }
        .background(Color(UIColor.systemBackground))
        
    }
}
