//
//  SpriteKitTimingFunctions.swift
//  Sonder
//
//  Created by Paul Mielle on 01/06/2020.
//  Copyright © 2020 Paul Mielle. All rights reserved.
//

import SpriteKit

class SpriteKitTimingFunctions {
    
    static var easeInOutExpo: SKActionTimingFunction = {
        var t: Float = $0
        if (t == 0) {
            return 0
        }
        if (t == 1) {
            return 1
        }
        return t<0.5 ? pow(2, 20 * t - 10) / 2 : (2 - pow(2, -20 * t + 10)) / 2
    }
    
    static var easeOutExpo: SKActionTimingFunction = {
        var t: Float = $0
        return t == 1 ? 1 : 1 - pow(2, -10 * t)
    }

}
