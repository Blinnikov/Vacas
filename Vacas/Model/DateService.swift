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
    return Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1))!
  }
  
  func workingDays(between start: Date, and end: Date) -> Int {
    guard start < end else { return 0 }
    let calendar = Calendar.current
    
    var workingDays = 0
    var date = start
    repeat {
      if Calendar.current.isDateInWeekend(date) {
        // weekendDays +=  1
      } else {
        workingDays += 1
      }
      date = calendar.date(byAdding: .day, value: 1, to: date)!
    } while date < end

    return workingDays
  }
  
  var workingDaysThisYear: Int {
    workingDays(between: firstDayOfCurrentyear, and: Date())
  }
}
