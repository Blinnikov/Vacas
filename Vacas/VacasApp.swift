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
  @StateObject var scheduleRecordsStore = ScheduleRecordsStore()
  @StateObject var statisticsViewModel: StatisticsViewModel
  @StateObject var calendarViewModel: CalendarViewModel
  
  init() {
    let store = SettingsStore(named: "Default")
    
    self._settingsStore = StateObject(wrappedValue: store)
    self._statisticsViewModel = StateObject(wrappedValue: StatisticsViewModel(with: store))
    self._calendarViewModel = StateObject(wrappedValue: CalendarViewModel(with: store))
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .preferredColorScheme(settingsStore.settings.appearance.getColorScheme())
        .environmentObject(settingsStore) // NOTE: Can we get rid of whis? Having so many view models seems excessive
        .environmentObject(scheduleRecordsStore)
        .environmentObject(statisticsViewModel)
        .environmentObject(calendarViewModel)
    }
  }
}
