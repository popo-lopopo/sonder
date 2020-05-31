//
//  issueGraphSKView.swift
//  Sonder
//
//  Created by Paul Mielle on 01/06/2020.
//  Copyright © 2020 Paul Mielle. All rights reserved.
//

import SwiftUI
import SpriteKit

class issueGraphSKView: SKView {
    var issueId: Binding<Int>
    
    init(frame: CGRect, issueId: Binding<Int>) {
        self.issueId = issueId
        super.init(frame: .zero)
        
    }
    // from google (?)
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
}
