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
  
  static let testData = [
    ScheduleRecord(title: "New Year", date: Date.from("2022-01-01"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "New Year Holiday week", date: Date.from("2022-01-02"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Emirates flight", date: Date.from("2022-01-02"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "New Year Holiday week", date: Date.from("2022-01-03"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Defender of the Fatherland Day", date: Date.from("2022-02-23"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Public Holiday", date: Date.from("2022-03-07"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "International Women's Day", date: Date.from("2022-03-08"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Vacation", date: Date.from("2022-03-08"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Vacation", date: Date.from("2022-03-09"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Vacation", date: Date.from("2022-03-10"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Vacation", date: Date.from("2022-03-11"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Test 01", date: Date.from("2022-03-31"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Test 02", date: Date.from("2022-03-31"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Test 03", date: Date.from("2022-03-31"), type: .timeOff(.vacation)),
  ]
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
