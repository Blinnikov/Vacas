//
//  ScheduleRecord+Extension.swift
//  Vacas
//
//  Created by Igor Blinnikov on 13.04.2022.
//

import SwiftUI

extension ScheduleRecord {
  var backgroundColor: Color {
    let lightPurpleRGBA = RGBAColor(red: RGBAColor.plum.red, green: RGBAColor.plum.green, blue: RGBAColor.plum.blue, alpha: 0.5)
    let lightPurple = Color(rgbaColor: lightPurpleRGBA)
    
    switch self.type {
    case .overtime:
      return lightPurple
    case .timeOff(let t):
      switch t {
      case .vacation:
        return Color.peach
      default:
        return lightPurple
      }
    }
  }
}
