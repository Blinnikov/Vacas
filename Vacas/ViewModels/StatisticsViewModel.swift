//
//  StatisticsViewModel.swift
//  Vacas
//
//  Created by Igor Blinnikov on 21.03.2022.
//

import SwiftUI
import Combine

class StatisticsViewModel: ObservableObject {
  @Published private var settingsStore: SettingsStore
  @Published private var recordsStore: ScheduleRecordsStore
  private let dateService = DateService()
  
  var settingsCancellable: AnyCancellable? = nil
  var recordsCancellable: AnyCancellable? = nil
  
  let MaximumDaysOffAllowed = 10
  
  init(with settingStore: SettingsStore, and recordsStore: ScheduleRecordsStore) {
    self.settingsStore = settingStore
    self.recordsStore = recordsStore
    
    // NOTE: It's a hack to make nested `ObservableObject`s work.
    // It just subscribes to nested object change event and rethrows updates further.
    // Thanks to https://stackoverflow.com/questions/58406287/how-to-tell-swiftui-views-to-bind-to-nested-observableobjects
    settingsCancellable = settingStore.objectWillChange.sink { [weak self] (_) in
      self?.objectWillChange.send()
    }
    
    recordsCancellable = recordsStore.objectWillChange.sink { [weak self] (_) in
      self?.objectWillChange.send()
    }
  }
  
  var totalVacationDaysPerYear: Int {
    settingsStore.settings.vacationDaysAmount + settingsStore.settings.extraVacationDaysAmount
  }
  
  var vacationDaysSpentThisYear: Int {
    recordsStore.records(of: ScheduleChangeType.timeOff(.vacation)).count
  }
  
  var vacationDaysLeftThisYear: Int {
    totalVacationDaysPerYear - vacationDaysSpentThisYear
  }
  
  var vacationDaysGained: Int {
    let vacationDaysPerMonth = Double(totalVacationDaysPerYear) / 12.0
    let workingDaysInMonth = 21 // TODO: How to get in on per month basis?
    let monthsWorked = Double(dateService.workingDaysThisYear) / Double(workingDaysInMonth)
    return Int(floor(vacationDaysPerMonth * monthsWorked))
  }
  
  var workingDaysThisYear: Int {
    dateService.workingDaysThisYear
  }
  
  var daysOffTaken: Int {
    recordsStore.records(of: ScheduleChangeType.timeOff(.personalTime)).count
  }
}
