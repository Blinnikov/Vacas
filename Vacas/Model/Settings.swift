//
//  Settings.swift
//  Vacas
//
//  Created by Igor Blinnikov on 13.02.2022.
//

import Foundation

struct Settings {
  var appearance: Appearance
  var tintColor: RGBAColor
  var hireDate: Date
  var vacationDaysAmount: Int
  var extraVacationDaysAmount: Int
}

struct RGBAColor: Codable, Equatable, Hashable {
  let red: Double
  let green: Double
  let blue: Double
  let alpha: Double
}

enum Appearance: String {
  case Light
  case Dark
  case System
}
