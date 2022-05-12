//
//  TimeOff.swift
//  Vacas
//
//  Created by Igor Blinnikov on 01.01.2022.
//

import Foundation

struct ScheduleRecord: Identifiable, Codable {
  var id = UUID()
  var title: String
  let date: Date
  var type: ScheduleChangeType
}

enum ScheduleChangeType: Hashable, Codable {
  case overtime
  case timeOff(TimeOffType)
}

enum TimeOffType: Codable {
  case vacation
  case parentalLeave
  case sickLeave
  case personalTime
  case holiday
}
