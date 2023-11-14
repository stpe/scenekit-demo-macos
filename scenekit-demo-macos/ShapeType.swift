//
//  ShapeType.swift
//  scenekit-demo-macos
//
//  Created by Stefan Pettersson on 2023-11-14.
//

import Foundation

public enum ShapeType: Int {

  case Box = 0
  case Sphere
  case Pyramid
  case Torus
  case Capsule
  case Cylinder
  case Cone
  case Tube

  static func random() -> ShapeType {
    let rand = Int.random(in: 0...Tube.rawValue)
    return ShapeType(rawValue: rand)!
  }
}
