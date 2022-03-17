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
//    return (weekendDays, workingDays)
    return workingDays
  }
  
  var workingDaysThisYear: Int {
    workingDays(between: firstDayOfCurrentyear, and: Date())
  }
  
  // TODO: take from settings
  var totalVacationDaysPerYear: Int {
    31
  }
  
  var vacationDaysSpentThisYear: Int {
    0
  }
  
  var vacationDaysLeftThisYear: Int {
    totalVacationDaysPerYear - vacationDaysSpentThisYear
  }
  
  var vacationDaysGained: Int {
    let vacationDaysPerMonth = Double(totalVacationDaysPerYear) / 12.0
    let workingDaysInMonth = 21 // TODO: How to get in on per month basis?
    let monthsWorked = Double(workingDaysThisYear) / Double(workingDaysInMonth)
    return Int(floor(vacationDaysPerMonth * monthsWorked))
  }
}
