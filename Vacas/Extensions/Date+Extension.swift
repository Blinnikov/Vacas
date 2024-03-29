//
//  Date+Extension.swift
//  Vacas
//
//  Created by Igor Blinnikov on 28.12.2021.
//

import Foundation

extension Date {
  
  func monthsOffset(from date: Date) -> Int {
    let calendar = Calendar.current
    let selfYear = calendar.component(.year, from: self)
    let dateYear = calendar.component(.year, from: date)
    let selfMonth = calendar.component(.month, from: self)
    let dateMonth = calendar.component(.month, from: date)
    
    return 12 * (selfYear - dateYear) + selfMonth - dateMonth
  }
  
  static func from(_ dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let result = dateFormatter.date(from: dateString)
    return result ?? Date()
  }
  
  // MARK: - String representation
  var yearString: String {
    let formatter = DateFormatter()
    // YYYY - shows 2022 in December 2021
    // yyyy - shows 2021 in December 2021
    formatter.dateFormat = "yyyy"
    return formatter.string(from: self)
  }
  
  var monthString: String {
    let formatter = DateFormatter()
    // MMMM - декабря
    // LLLL - декабрь
    formatter.dateFormat = "LLLL"
    return formatter.string(from: self)
  }
  
  // MARK: - Days function
  func allDaysOfMonth() -> [Date] {
    let calendar = Calendar.current
    let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
    let range = calendar.range(of: .day, in: .month, for: startDate)!
    
    let result = range.compactMap { day -> Date in
      return calendar.date(byAdding: .day, value: day == 1 ? 0 : day - 1, to: startDate)!
    }
    return result
  }
  
  func theSameDay(in monthOffset: Int) -> Date {
    let calendar = Calendar.current
    guard let result = calendar.date(byAdding: .month, value: monthOffset, to: self) else {
      return Date()
    }
    
    return result
  }
  
  // MARK: - Comparison
  func inSameDayAs(_ date: Date) -> Bool {
    let calendar = Calendar.current
    return calendar.isDate(self, inSameDayAs: date)
  }
}
