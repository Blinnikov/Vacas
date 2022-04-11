//
//  TimeOff.swift
//  Vacas
//
//  Created by Igor Blinnikov on 01.01.2022.
//

import Foundation

struct ScheduleRecord: Identifiable {
  let id = UUID()
  var title: String
  let date: Date
  var type: ScheduleChangeType
}

enum ScheduleChangeType: Hashable {
  case overtime
  case timeOff(TimeOffType)
}

enum TimeOffType {
  case vacation
  case parentalLeave
  case sickLeave
  case personalTime
  case holiday
}
