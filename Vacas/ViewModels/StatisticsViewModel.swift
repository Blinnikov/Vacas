//
//  StatisticsViewModel.swift
//  Vacas
//
//  Created by Igor Blinnikov on 21.03.2022.
//

import SwiftUI

class StatisticsViewModel: ObservableObject {
  private let settingsStore: SettingsStore
  private let dateService = DateService()
  
  init(with settingStore: SettingsStore) {
    self.settingsStore = settingStore
  }
  
  private var totalVacationDaysPerYear: Int {
    settingsStore.settings.vacationDaysAmount + settingsStore.settings.extraVacationDaysAmount
  }
  
  var vacationDaysSpentThisYear: Int {
    // TODO: Probably we need to introduce new kind of store
    // that will look after akk the data that user enters,
    // like days oof, vacations and so on.
    // `vacationDaysSpentThisYear` should be either direct projection from this store
    // or computed field based on data from this store
    0
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
}
