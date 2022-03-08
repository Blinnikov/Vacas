//
//  DateService.swift
//  Vacas
//
//  Created by Igor Blinnikov on 01.03.2022.
//

import Foundation

struct DateService {
  func getToday() -> Date {
    return Date()
  }
  
  var firstDayOfCurrentyear: Date {
    let year = Calendar.current.component(.year, from: Date())
    return Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1))!
  }
  
  func firstDay(of year: Int) -> Date {
    // Get the current year
    // let year = Calendar.current.component(.year, from: Date())
    // Get the first day of next year
//    if let firstOfNextYear = Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1)) {
//        // Get the last day of the current year
//        let lastOfYear = Calendar.current.date(byAdding: .day, value: -1, to: firstOfNextYear)
//    }
    return Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1))!
  }
}
