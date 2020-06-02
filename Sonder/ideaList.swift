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
        let a = idea(name: "aaa")
        let b = idea(name: "bbb")
        let c = idea(name: "ccc")
        let d = idea(name: "ddd")
        let e = idea(name: "eee")
        let ideas = [a,b,c,d,e]
        return List {
            ForEach(ideas) { idea in
                ideaRow(idea: idea)
                    .listRowInsets(EdgeInsets(
                        top: 30,
                        leading: 30,
                        bottom: 30,
                        trailing: 30))
            }
        }
        
    }
}
