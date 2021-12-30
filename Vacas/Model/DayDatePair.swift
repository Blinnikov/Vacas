//
//  DateValue.swift
//  Vacas
//
//  Created by Igor Blinnikov on 28.12.2021.
//

import Foundation

struct DayDatePair: Identifiable {
  var id = UUID()
  var day: Int
  var date: Date?
}
