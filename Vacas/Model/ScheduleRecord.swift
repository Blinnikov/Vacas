//
//  TimeOff.swift
//  Vacas
//
//  Created by Igor Blinnikov on 01.01.2022.
//

import Foundation

struct ScheduleRecord: Identifiable {
  let id = UUID()
  let title: String
  let date: Date
  let type: ScheduleChangeType
}

enum ScheduleChangeType {
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
