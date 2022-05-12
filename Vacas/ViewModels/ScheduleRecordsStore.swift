//
//  ScheduleRecordsStore.swift
//  Vacas
//
//  Created by Igor Blinnikov on 14.04.2022.
//

import Foundation

class ScheduleRecordsStore: ObservableObject {
  let name: String
  
  @Published private var records = [ScheduleRecord]() {
    didSet {
      storeInUserDefaults()
    }
  }
  
  private var userDefaultsKey: String {
    "ScheduleRecordsStore:" + name
  }
  
  private func storeInUserDefaults() {
    UserDefaults.standard.set(try? JSONEncoder().encode(records), forKey: userDefaultsKey)
    print("Saved records in UserDefaults")
  }
  
  private func restoreFromUserDefaults() {
    if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
       let decodedRecords = try? JSONDecoder().decode([ScheduleRecord].self, from: jsonData) {
      records = decodedRecords
    }
  }
  
  init(named name: String) {
    self.name = name
    restoreFromUserDefaults()
    
    if records.isEmpty {
      print("using built-in records")
      records = ScheduleRecord.testData
    } else {
      print("successfully loaded records from UserDefaults: \(records)")
    }
  }
  
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
