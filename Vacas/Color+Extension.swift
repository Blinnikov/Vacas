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
