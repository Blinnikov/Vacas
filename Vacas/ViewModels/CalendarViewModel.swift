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
}
