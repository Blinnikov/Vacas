//
//  VacasApp.swift
//  Vacas
//
//  Created by Igor Blinnikov on 23.12.2021.
//

import SwiftUI

@main
struct VacasApp: App {
  @StateObject var settingsStore = SettingsStore(named: "Default")
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .preferredColorScheme(settingsStore.settings.appearance.getColorScheme())
        .environmentObject(settingsStore)
    }
  }
}
