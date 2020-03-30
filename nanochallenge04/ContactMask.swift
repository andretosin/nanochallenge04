//
//  ContactMask.swift
//  nanochallenge04
//
//  Created by Andre Tosin on 10/03/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

enum ContactMask: UInt32 {
    case player =       0b1
    case walls =        0b10
    case star =         0b100
    case rock =         0b1000
    case orange =       0b10000
    case watermelon =   0b100000
    case cherry =       0b1000000
}
