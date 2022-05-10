//
//  ScheduleRecordsStore.swift
//  Vacas
//
//  Created by Igor Blinnikov on 14.04.2022.
//

import Foundation

class ScheduleRecordsStore: ObservableObject {
  @Published private var records: [ScheduleRecord] = ScheduleRecord.testData
  
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
  
  func add(_ record: ScheduleRecord) async {
    self.records.append(record)
  }
  
  @MainActor
  @discardableResult
  func removeAsync(_ record: ScheduleRecord) async -> ScheduleRecord? {
    if let index = self.records.firstIndex(where: { r in r.id == record.id }) {
      return self.records.remove(at: index)
    }
    
    return nil
  }
  
  @discardableResult
  func remove(_ record: ScheduleRecord) -> ScheduleRecord? {
    if let index = self.records.firstIndex(where: { r in r.id == record.id }) {
      return self.records.remove(at: index)
    }
    
    return nil
  }
}
