//
//  ScheduleRecord.TestData.swift
//  Vacas
//
//  Created by Igor Blinnikov on 09.04.2022.
//

import Foundation

extension ScheduleRecord {
  static func loadInitialData(for year: Int, includeTestData: Bool = false) -> [ScheduleRecord] {
    // TODO: Add some filtration by year in the future in case we have records not only for 2022
    var result = nationalHolidays
    if includeTestData {
      result += vacations + forTesting
    }
    
    return result
  }
  
  private static let nationalHolidays = [
    ScheduleRecord(title: "New Year's Day", date: Date.from("2022-01-01"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "New Year Holiday", date: Date.from("2022-01-02"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "New Year Holiday", date: Date.from("2022-01-03"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "New Year Holiday", date: Date.from("2022-01-04"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "New Year Holiday", date: Date.from("2022-01-05"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "New Year Holiday", date: Date.from("2022-01-06"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Orthodox Christmas Day", date: Date.from("2022-01-07"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "New Year Holiday", date: Date.from("2022-01-08"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "New Year Holiday", date: Date.from("2022-01-09"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Defender of the Fatherland Day", date: Date.from("2022-02-23"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Public Holiday", date: Date.from("2022-03-07"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "International Women's Day", date: Date.from("2022-03-08"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Spring and Labor Day", date: Date.from("2022-05-01"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Day off for Spring and Labor Day", date: Date.from("2022-05-02"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Public Holiday", date: Date.from("2022-05-03"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Victory Day", date: Date.from("2022-05-09"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Public Holiday", date: Date.from("2022-05-10"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Russia Day", date: Date.from("2022-06-12"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Day off for Russia Day", date: Date.from("2022-06-13"), type: .timeOff(.holiday)),
    ScheduleRecord(title: "Unity Day", date: Date.from("2022-11-04"), type: .timeOff(.holiday)),
  ]
  
  private static let vacations = [
    ScheduleRecord(title: "Vacation", date: Date.from("2022-03-08"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Vacation", date: Date.from("2022-03-09"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Vacation", date: Date.from("2022-03-10"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Vacation", date: Date.from("2022-03-11"), type: .timeOff(.vacation)),
  ]
  
  private static let forTesting = [
    ScheduleRecord(title: "Emirates flight", date: Date.from("2022-01-02"), type: .timeOff(.vacation)),
    
    ScheduleRecord(title: "Test 01", date: Date.from("2022-03-31"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Test 02", date: Date.from("2022-03-31"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Test 03", date: Date.from("2022-03-31"), type: .timeOff(.vacation)),
    
    ScheduleRecord(title: "Show more test 01", date: Date.from("2022-05-03"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Show more test 02", date: Date.from("2022-05-03"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Show more test 03", date: Date.from("2022-05-03"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Show more test 04", date: Date.from("2022-05-03"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Show more test 05", date: Date.from("2022-05-03"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Show more test 06", date: Date.from("2022-05-03"), type: .timeOff(.vacation)),
    ScheduleRecord(title: "Show more test 07", date: Date.from("2022-05-03"), type: .timeOff(.vacation)),
  ]
}
