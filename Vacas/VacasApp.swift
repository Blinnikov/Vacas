//
//  VacasApp.swift
//  Vacas
//
//  Created by Igor Blinnikov on 23.12.2021.
//

import SwiftUI

@main
struct VacasApp: App {
  @StateObject var settingsStore: SettingsStore
  @StateObject var statisticsViewModel: StatisticsViewModel
  
  init() {
    let store = SettingsStore(named: "Default")
    
    self._settingsStore = StateObject(wrappedValue: store)
    self._statisticsViewModel = StateObject(wrappedValue: StatisticsViewModel(with: store))
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .preferredColorScheme(settingsStore.settings.appearance.getColorScheme())
        .environmentObject(settingsStore)
        .environmentObject(statisticsViewModel)
    }
  }
}
