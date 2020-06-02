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
        Text("\(idea.name) is a cool idea name lol")
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
        return List(ideas) { idea in
            ideaRow(idea: idea)
        }
    }
}
