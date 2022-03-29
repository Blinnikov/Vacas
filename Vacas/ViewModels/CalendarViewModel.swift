//
//  CalendarViewModel.swift
//  Vacas
//
//  Created by Igor Blinnikov on 29.03.2022.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
  private var settingsStore: SettingsStore
  
  init(with store: SettingsStore) {
    self.settingsStore = store
  }
  
  var selectionColor: Color {
    settingsStore.settings.color
  }
  
  func backgroundColor(for record: ScheduleRecord) -> Color {
    let lightPurpleRGBA = RGBAColor(red: RGBAColor.plum.red, green: RGBAColor.plum.green, blue: RGBAColor.plum.blue, alpha: 0.5)
    let lightPurple = Color(rgbaColor: lightPurpleRGBA)
    
    switch record.type {
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
