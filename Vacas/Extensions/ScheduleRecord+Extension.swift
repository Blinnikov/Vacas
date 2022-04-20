//
//  ScheduleRecord+Extension.swift
//  Vacas
//
//  Created by Igor Blinnikov on 13.04.2022.
//

import SwiftUI

fileprivate let lightPurpleRGBA = RGBAColor(red: RGBAColor.plum.red, green: RGBAColor.plum.green, blue: RGBAColor.plum.blue, alpha: 0.5)
fileprivate let lightPurple = Color(rgbaColor: lightPurpleRGBA)
fileprivate let dayOffColor = Color(red: 230, green: 54, blue: 93)

extension ScheduleRecord {
  var backgroundColor: Color {
    switch self.type {
    case .overtime:
      return lightPurple
    case .timeOff(let t):
      switch t {
      case .vacation:
        return Color.peach
      case .personalTime: return dayOffColor
      default:
        return lightPurple
      }
    }
  }
}
