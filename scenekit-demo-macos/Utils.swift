//
//  Utils.swift
//  scenekit-demo-macos
//
//  Created by Stefan Pettersson on 2023-11-14.
//

import Foundation
import SwiftUI

let NSColorList:[NSColor] = [
    NSColor.blue,
    NSColor.white,
    NSColor.red,
    NSColor.green,
    NSColor.blue,
    NSColor.yellow,
    NSColor.cyan,
    NSColor.lightGray,
    NSColor.magenta,
    NSColor.orange,
    NSColor.purple
]

struct Utils {
    public static func randomColor() -> NSColor {
        let rand = Int.random(in: 0...NSColorList.count - 1)
        return NSColorList[rand]
    }
}
