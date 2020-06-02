//
//  idea.swift
//  Sonder
//
//  Created by Paul Mielle on 01/06/2020.
//  Copyright © 2020 Paul Mielle. All rights reserved.
//

import SwiftUI

struct idea: Identifiable {
    var id = UUID()
    var name: String
}

struct timeperiod: Identifiable {
    var id = UUID()
    var name: String
    var contentideas: [idea]
}
