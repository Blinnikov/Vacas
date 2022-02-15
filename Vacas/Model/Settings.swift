//
//  Settings.swift
//  Vacas
//
//  Created by Igor Blinnikov on 13.02.2022.
//

import Foundation

struct Settings: Codable {
  var appearance: Appearance
  var tintColor: RGBAColor
  var hireDate: Date
  var vacationDaysAmount: Int
  var extraVacationDaysAmount: Int
}

extension Settings {
  init() {
    self.appearance = .System
    self.tintColor = .selection
    self.hireDate = Date()
    self.vacationDaysAmount = 28
    self.extraVacationDaysAmount = 3
  }
}

struct RGBAColor: Codable, Equatable, Hashable {
  let red: Double
  let green: Double
  let blue: Double
  let alpha: Double
}

extension RGBAColor {
  static var selection = RGBAColor(red: 0.994, green: 0.51, blue: 0.515, alpha: 1.0)
  static let peach = RGBAColor(red: 0.997, green: 0.743, blue: 0.515, alpha: 1.0)
  static let plum = RGBAColor(red: 0.568, green: 0.495, blue: 0.967, alpha: 1.0)
}

enum Appearance: String, Codable {
  case Light
  case Dark
  case System
}
