//
//  Date+Extension.swift
//  Vacas
//
//  Created by Igor Blinnikov on 28.12.2021.
//

import Foundation

extension Date {
  func getAllDates() -> [Date] {
    let calendar = Calendar.current
    let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
    print("Start date: \(startDate)")
    let range = calendar.range(of: .day, in: .month, for: startDate)!
    
    print(range)
    
    let result = range.compactMap { day -> Date in
      return calendar.date(byAdding: .day, value: day == 1 ? 0 : day - 1, to: startDate)!
    }
    
    print(result)
    return result
  }
}
