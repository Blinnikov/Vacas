//
//  Date+Extension.swift
//  Vacas
//
//  Created by Igor Blinnikov on 28.12.2021.
//

import Foundation

extension Date {
  func localDate() -> Date {
    let calendar = Calendar.current
    let utc = self
    let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: utc))
    guard let localDate = calendar.date(byAdding: .second, value: Int(timeZoneOffset), to: utc) else {
      return self
    }
    
    return localDate
  }
  
  func allDaysOfMonth() -> [Date] {
    let calendar = Calendar.current
    let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!.localDate()
    let range = calendar.range(of: .day, in: .month, for: startDate)!
    
    let result = range.compactMap { day -> Date in
      return calendar.date(byAdding: .day, value: day == 1 ? 0 : day - 1, to: startDate)!
    }
    return result
  }
}
