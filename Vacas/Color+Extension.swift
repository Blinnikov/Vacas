//
//  Color+Extension.swift
//  Vacas
//
//  Created by Igor Blinnikov on 30.12.2021.
//

import SwiftUI

extension Color {
  static let selection = Self.init(.sRGB, red: 0.994, green: 0.51, blue: 0.515, opacity: 1.0)
  static let peach = Self.init(.sRGB, red: 0.997, green: 0.743, blue: 0.515, opacity: 1.0)
  static let plum = Self.init(.sRGB, red: 0.568, green: 0.495, blue: 0.967, opacity: 1.0)
  
  init(rgbaColor rgba: RGBAColor) {
    self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
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
