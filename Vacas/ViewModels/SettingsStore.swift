//
//  SettingsStore.swift
//  Vacas
//
//  Created by Igor Blinnikov on 14.02.2022.
//

import SwiftUI

class SettingsStore: ObservableObject {
  var name: String
  
  @Published var settings = Settings() {
    didSet {
      scheduleAutoSave()
    }
  }
  
  private var autoSaveTimer: Timer?
  private let AutoSaveInterval = 1.0
  
  private func scheduleAutoSave() {
    autoSaveTimer?.invalidate()
    autoSaveTimer = Timer.scheduledTimer(withTimeInterval: AutoSaveInterval, repeats: false) { _ in
      self.storeInUserDefaults()
    }
  }
  
  init(named name: String) {
    self.name = name
    restoreFromUserDefaults()
  }
  
  private var userDefaultsKey: String {
    "SettingsStore:\(name)"
  }
  
  private func storeInUserDefaults() {
    let data = try? JSONEncoder().encode(settings)
    UserDefaults.standard.set(data, forKey: userDefaultsKey)
    
    print("Store settings in UserDefaults")
  }
  
  private func restoreFromUserDefaults() {
    if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
       let decodedSettings = try? JSONDecoder().decode(Settings.self, from: jsonData) {
      settings = decodedSettings
    }
  }
}
