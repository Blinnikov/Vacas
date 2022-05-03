//
//  ScheduleRecordsStore.swift
//  Vacas
//
//  Created by Igor Blinnikov on 14.04.2022.
//

import Foundation

class ScheduleRecordsStore: ObservableObject {
  @Published var records: [ScheduleRecord] = ScheduleRecord.testData
  
  func first() -> ScheduleRecord? {
    records.first
  }
  
  func first(_ amount: Int) -> [ScheduleRecord] {
    Array(records.prefix(amount))
  }
  
  func last() -> ScheduleRecord? {
    records.last
  }
  
  func last(_ amount: Int) -> [ScheduleRecord] {
    Array(records.suffix(amount))
  }
  
  func records(of type: ScheduleChangeType) -> [ScheduleRecord] {
    records.filter { record in
      record.type == type
    }
  }
  
  func records(for date: Date) -> [ScheduleRecord] {
    records.filter { record in
      record.date.inSameDayAs(date)
    }
  }
  
  func add(_ record: ScheduleRecord) {
    self.records.append(record)
  }
  
  @discardableResult
  func remove(_ record: ScheduleRecord) -> ScheduleRecord? {
    // TODO: It looks like removal works wrong
    if let index = self.records.firstIndex(where: { r in r.id == record.id }) {
      return self.records.remove(at: index)
    }
    
    return nil
  }
}
