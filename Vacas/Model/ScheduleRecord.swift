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
  
  private static func dateFromString(_ dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let result = dateFormatter.date(from: dateString)
    return result ?? Date()
  }
  
  static let testData = [
    ScheduleRecord(title: "New Year", date: dateFromString("2022-01-01"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "New Year Holiday week", date: dateFromString("2022-01-02"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Emirates flight", date: dateFromString("2022-01-02"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "New Year Holiday week", date: dateFromString("2022-01-03"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Defender of the Fatherland Day", date: dateFromString("2022-02-23"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Public Holiday", date: dateFromString("2022-03-07"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "International Women's Day", date: dateFromString("2022-03-08"), type: .timeOff(.holiday)),
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
