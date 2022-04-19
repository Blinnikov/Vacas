//
//  Color+Extension.swift
//  Vacas
//
//  Created by Igor Blinnikov on 30.12.2021.
//

import SwiftUI

extension Color {
  static let bloodOrange = Self.init(rgbaColor: .bloodOrange)
  static let peach = Self.init(rgbaColor: .peach)
  static let plum = Self.init(rgbaColor: .plum)
  static let snow = Self.init(rgbaColor: .snow)
  
  init(rgbaColor rgba: RGBAColor) {
    self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
  }
  
  init(red: Double, green: Double, blue: Double) {
    self.init(.sRGB, red: red / 255, green: green / 255, blue: blue / 255, opacity: 1.0)
  }
}

extension RGBAColor {
  init(color: Color) {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
  }
}
